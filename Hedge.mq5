#include <Trade/Trade.mqh>
CTrade trade;

bool First = true;
bool TradingAllowed = false;

string StartTradingTime = "09:00";
string StopTradingTime = "22:00";
string CurrentTime;

double currentPositionTP;
double currentPositionSL;
double PositionDirection;
double openPrice;


double Ask = NormalizeDouble(SymbolInfoDouble (_Symbol, SYMBOL_ASK), _Digits);
double Bid = NormalizeDouble(SymbolInfoDouble (_Symbol, SYMBOL_BID), _Digits); 


void FirstTrade(){
   if(First == true){
      trade.Buy(1,_Symbol,Ask,Ask-(100*_Point),Ask+(200*_Point),NULL);
   }
   First = false;
}

void Trade(){
   if(OrdersTotal() == 0){
      if(PositionsTotal() == 1){
         if(PositionDirection == 0){
            trade.BuyStop(1,currentPositionTP,_Symbol,currentPositionTP-(100*_Point),currentPositionTP+(200*_Point),ORDER_TIME_GTC,0,0);
            trade.SellStop(1,currentPositionSL,_Symbol,currentPositionSL+(100*_Point),currentPositionSL-(200*_Point),ORDER_TIME_GTC,0,0);
         }
         if(PositionDirection == 1){
            trade.BuyStop(1,currentPositionSL,_Symbol,currentPositionSL -(100*_Point),currentPositionSL+(200*_Point),ORDER_TIME_GTC,0,0);
            trade.SellStop(1,currentPositionTP,_Symbol,currentPositionTP+(100*_Point),currentPositionTP-(200*_Point),ORDER_TIME_GTC,0,0);
         }
      }
   }
}

void CancelOrder(){
   for(int i = OrdersTotal() - 1; i>=0; i--){
      if(OrdersTotal()==1){
         ulong OrderTicket = OrderGetTicket(i);
         trade.OrderDelete(OrderTicket);
      }
   }
}

double Volume(){
   double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
   
   return (Balance * 0.00001);
}

bool CheckTradingTime(){

   if(StringSubstr(CurrentTime,0,5)==StartTradingTime)
   TradingAllowed = true;
   
   
   if(StringSubstr(CurrentTime,0,5)==StopTradingTime)
   TradingAllowed = false;      
   
   
   return TradingAllowed;
   
}

void OnTick()
  {    
  
   datetime time= TimeLocal();
   CurrentTime = TimeToString(time, TIME_MINUTES);
   
   if(CheckTradingTime() == true){   
      FirstTrade();
         for(int i = PositionsTotal()-1; i>=0; i--){
            ulong PositionTicket = PositionGetTicket(i); 
            currentPositionTP = PositionGetDouble(POSITION_TP);
            currentPositionSL = PositionGetDouble(POSITION_SL);
            openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
            PositionDirection =(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
         }
         if(PositionsTotal() == 1){
            Trade();
         }
         if(OrdersTotal() == 1){
            CancelOrder();
         }
      }
      if(CheckTradingTime() == false){
         First = true;
         CancelOrder();
      }
      
      Comment("Position TP " + currentPositionTP + " "
               "Position SL " + currentPositionSL + " "
               "Position Direction " + PositionDirection + " "
               "Position Open Price " + openPrice);
               
   
  }


