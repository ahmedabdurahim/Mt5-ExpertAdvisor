#include <Trade/Trade.mqh>

CTrade trade;


double Ask = NormalizeDouble(SymbolInfoDouble (_Symbol, SYMBOL_ASK), _Digits);
double Bid = NormalizeDouble(SymbolInfoDouble (_Symbol, SYMBOL_BID), _Digits);

double Balance = AccountInfoDouble(ACCOUNT_BALANCE);
double Equity = AccountInfoDouble(ACCOUNT_EQUITY); 

ulong PositionTicket;
double currentPositionTP;
double currentPositionSL;
double openPrice;
int PositionDirection;


double MovingAverage(int MA, int candle){
   double MovingAverageArray[];
   int MovingAverageDefinition = iMA(_Symbol,_Period,MA,0,MODE_EMA,PRICE_CLOSE);
   ArraySetAsSeries(MovingAverageArray, true);
   CopyBuffer(MovingAverageDefinition,0,0,20,MovingAverageArray);
   double MovingAverageValue = NormalizeDouble(MovingAverageArray[candle], _Digits);
   
   return MovingAverageValue;
}

float MACD(){
   double PriceArray[];
   int MACDDefinition = iMACD(_Symbol, _Period,12,26,9,PRICE_CLOSE);
   ArraySetAsSeries(PriceArray, true);
   CopyBuffer(MACDDefinition,0,0,3,PriceArray);
   
   float MACDValue = (PriceArray[0]);
   
   return MACDValue;
}

double RelativeStrengthIndex(){
   double RSIArray[];
   int RsiDefinition = iRSI(_Symbol,_Period,14,PRICE_CLOSE);
   ArraySetAsSeries(RSIArray,true);
   CopyBuffer(RsiDefinition,0,0,3,RSIArray);
   
   double RsiValue = NormalizeDouble(RSIArray[0], 2);
   
   return RsiValue;
}

void SetPositionInfo(){
   for(int i = PositionsTotal()-1; i>=0; i--){
         PositionTicket = PositionGetTicket(i); 
         currentPositionTP = PositionGetDouble(POSITION_TP);
         currentPositionSL = PositionGetDouble(POSITION_SL);
         openPrice = PositionGetDouble(POSITION_PRICE_OPEN);
         PositionDirection =(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
      }
}

bool ExitPosition(){
   bool PositionStatus = true;
   
   if(PositionsTotal() > 0){
      SetPositionInfo();
      if(PositionDirection == 0){
         if(MovingAverage(10,0) < MovingAverage(50,0)){
            PositionStatus = false;
         }
      }
      if(PositionDirection == 1){
         if(MovingAverage(10,0) > MovingAverage(50,0)){
            PositionStatus = false;
         }
      }
      
   }
   
   return PositionStatus;
}

double TradeVolume(){
   double Volume = MathRound((Balance * 0.0001));
   
   return Volume;
}

void OnTick()
  {   
      if(PositionsTotal() == 0){
         if(MovingAverage(10,0) > MovingAverage(50, 1)){
            if(MACD() > 0.000280){
               trade.Sell(0.01,_Symbol,Bid);
            }
         }
      }
      if(PositionsTotal() == 0){
         if(MovingAverage(10,0) < MovingAverage(50, 1)){
            if(MACD() < -0.000280){
                  trade.Buy(0.01,_Symbol,Ask);
            }
         }
      }
      
      if(ExitPosition() == false){
         trade.PositionClose(PositionTicket);
      }
      
      if((Equity - Balance) > (Balance/2.5)){
         trade.PositionClose(PositionTicket);
         Print("Position Closed");
      }
      
      if((Balance - Equity) > 50000){
         trade.PositionClose(PositionTicket);
         Print("Position Closed");
      }
        
      Comment("RSI Value " + RelativeStrengthIndex() + "\n"
               "MACD Value " + MACD() + "\n"
               "Moving Average " + MovingAverage(50,0));
  }

