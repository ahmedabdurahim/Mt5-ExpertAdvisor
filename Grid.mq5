#include <Trade/Trade.mqh>

CTrade trade;

double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
input int Grid = 100;
double GridPrice;

void OnInit(){
   GridPrice = Grid(Ask,Grid);
}

void OnTick(){
   
}

double Grid(double Price, int GridPts){
   double grid = NormalizeDouble(Price + (GridPts * _Point), _Digits);
   return grid;
}

double GetProfit(){
   double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
   double Equity = AccountInfoDouble(ACCOUNT_EQUITY);
   double profit;
   
   if((Equity-Balance) < 0){
      profit = NormalizeDouble(Equity - Balance, 2);;
   }else if((Equity - Balance) > 0){
      profit = NormalizeDouble(Equity - Balance, 2);
   }
   
   return profit;
   
}

void CloseAllTrades(){
   for(int i = PositionsTotal() - 1; i>=0; i--){
      if(PositionsTotal()>0){
         ulong PositionTicket = PositionGetTicket(i);
         //trade.OrderDelete(OrderTicket);
         trade.PositionClose(PositionTicket);
      }
   }
}

void CloseCertainTrades(string posType){
   for(int i = PositionsTotal() - 1; i>=0; i--){
      if(PositionsTotal()>0){
         ulong PositionTicket = PositionGetTicket(i);
         PositionSelectByTicket(PositionTicket);
         int PositionDirection =(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
         if(PositionDirection == 1 && posType == "sell"){
            trade.PositionClose(PositionTicket);
         }
         if(PositionDirection == 0 && posType == "buy"){
            trade.PositionClose(PositionTicket);
         }
      }
   }
}

// The code below this line has a logical error FIXX PLss

double GetTradesProfit(string posType){
    double Profit;
    for(int i = PositionsTotal() - 1; i>=0; i--){
      if(PositionsTotal()>0){
         double PositionDirection =(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
         ulong PositionTicket = PositionGetTicket(i);
         if(posType == "sell" && PositionDirection == 1){
            Profit = PositionGetDouble(POSITION_PROFIT) + Profit;
         }
         if(posType == "buy" && PositionDirection == 0){
            Profit = PositionGetDouble(POSITION_PROFIT) + Profit;
         }
      }
   }
   return Profit;
}

int CountTrades(string posType){
   int posCount = 0;
   for(int i = PositionsTotal() - 1; i>=0; i--){
      if(PositionsTotal()>0){
         double PositionDirection =(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
         ulong PositionTicket = PositionGetTicket(i);
         if(posType == "sell" && PositionDirection == 1){
            posCount++;
         }
         if(posType == "buy" && PositionDirection == 0){
            posCount++;
         }
      }
   }
   return posCount;
}

