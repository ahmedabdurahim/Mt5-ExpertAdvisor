#include <Trade/Trade.mqh>


CTrade trade;

double Ask = NormalizeDouble(SymbolInfoDouble (_Symbol, SYMBOL_ASK), _Digits);
double Bid = NormalizeDouble(SymbolInfoDouble (_Symbol, SYMBOL_BID), _Digits); 

ulong PositionTicket;
double currentPositionTP;
double currentPositionSL;
double openPrice;
int PositionDirection;

void OnTick()
  {
      SetPositionInfo(); 
      if(RelativeStrengthIndex() > 70 && SellEngulfingCandle() == true && PositionsTotal() == 0){
         trade.Sell(0.10,_Symbol);
      }
      if(RelativeStrengthIndex() < 30 && BuyEngulfingCandle() == true && PositionsTotal() == 0){
         trade.Buy(0.10,_Symbol);
      }
      
      CheckAndClose();
      
  }

bool SellEngulfingCandle(){
   bool Engulfing = false;
   MqlRates PriceInformation[];
   ArraySetAsSeries(PriceInformation, true); 
   int Data = CopyRates(_Symbol,PERIOD_CURRENT,0,10, PriceInformation);
   
   if(PriceInformation[3].close > PriceInformation[4].close){
      if(PriceInformation[2].close > PriceInformation[3].close){
         if(PriceInformation[1].close < PriceInformation[2].close){
            Engulfing = true;
         }
      }
   }
   
   return Engulfing;

}

bool BuyEngulfingCandle(){
   bool Engulfing = false;
   MqlRates PriceInformation[];
   ArraySetAsSeries(PriceInformation, true); 
   int Data = CopyRates(_Symbol,PERIOD_CURRENT,0,10, PriceInformation);
   
   if(PriceInformation[3].close < PriceInformation[4].close){
      if(PriceInformation[2].close < PriceInformation[3].close){
         if(PriceInformation[1].close > PriceInformation[2].close){
            Engulfing = true;
         }
      }
   }
   
   return Engulfing;

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

void CheckAndClose(){
   if(PositionsTotal() > 0){
      if(PositionDirection == 1){
         if(RelativeStrengthIndex() == 35){
            trade.PositionClose(PositionTicket);
         }
      }
      
      if(PositionDirection == 0){
         if(RelativeStrengthIndex() == 65){
            trade.PositionClose(PositionTicket);
         }
      }
   }
   
}


