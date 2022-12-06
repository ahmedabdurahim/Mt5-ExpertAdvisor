#include  <Trade/Trade.mqh>

CTrade trade;

double Ask, Bid;

void OnDeinit(){
   ObjectDelete(_Symbol, "Buy Button");
   ObjectDelete(_Symbol, "Sell Button");
   ObjectDelete(_Symbol, "TP points");
   ObjectDelete(_Symbol, "RRR");
   ObjectDelete(_Symbol, "RRRText");
   ObjectDelete(_Symbol, "TPointsText");
   ObjectDelete(_Symbol, "Ask");
   ObjectDelete(_Symbol, "Bid");
   ObjectDelete(_Symbol, "spread");
   
   
   
}


void OnTick(){
   
   Ask = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
   Bid = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
   
   ChartSetInteger(0,CHART_FOREGROUND,0,false);
   ChartSetInteger(0,CHART_SCALE,0, 10);
   
   //buy Button
   ObjectCreate(_Symbol,"Buy Button",OBJ_BUTTON,0,0,0);
   
   ObjectSetInteger(_Symbol,"Buy Button", OBJPROP_XDISTANCE, 930);
   ObjectSetInteger(_Symbol,"Buy Button", OBJPROP_XSIZE, 100);
   ObjectSetInteger(_Symbol,"Buy Button", OBJPROP_YDISTANCE, 190);
   ObjectSetInteger(_Symbol,"Buy Button", OBJPROP_YSIZE, 50);
   ObjectSetInteger(_Symbol,"Buy Button", OBJPROP_CORNER, 2);
   ObjectSetString(_Symbol,"Buy Button", OBJPROP_TEXT, "BUY"); 
   ObjectSetInteger(_Symbol,"Buy Button", OBJPROP_BGCOLOR, clrGreen);
   
   //sell Button
   ObjectCreate(_Symbol,"Sell Button",OBJ_BUTTON,0,0,0);
   
   ObjectSetInteger(_Symbol,"Sell Button", OBJPROP_XDISTANCE, 930);
   ObjectSetInteger(_Symbol,"Sell Button", OBJPROP_XSIZE, 100);
   ObjectSetInteger(_Symbol,"Sell Button", OBJPROP_YDISTANCE, 125);
   ObjectSetInteger(_Symbol,"Sell Button", OBJPROP_YSIZE, 50);
   ObjectSetInteger(_Symbol,"Sell Button", OBJPROP_CORNER, 2);
   ObjectSetString(_Symbol,"Sell Button", OBJPROP_TEXT, "SELL");
   ObjectSetInteger(_Symbol,"Sell Button", OBJPROP_BGCOLOR, clrRed);
   
   //TP points input field
   ObjectCreate(_Symbol,"TP points",OBJ_EDIT,0,0,0);
   
   ObjectSetInteger(_Symbol,"TP points", OBJPROP_XDISTANCE, 930);
   ObjectSetInteger(_Symbol,"TP points", OBJPROP_XSIZE, 100);
   ObjectSetInteger(_Symbol,"TP points", OBJPROP_YDISTANCE, 270);
   ObjectSetInteger(_Symbol,"TP points", OBJPROP_YSIZE, 20);
   ObjectSetInteger(_Symbol,"TP points", OBJPROP_CORNER, 2);
   //ObjectSetString(_Symbol,"TP points", OBJPROP_TEXT, "TP points");
   ObjectSetInteger(_Symbol,"TP points", OBJPROP_BGCOLOR, clrAqua);
   
   //stop loss input text field
   ObjectCreate(_Symbol,"stopLoss",OBJ_EDIT,0,0,0);
   
   ObjectSetInteger(_Symbol,"stopLoss", OBJPROP_XDISTANCE, 930);
   ObjectSetInteger(_Symbol,"stopLoss", OBJPROP_XSIZE, 100);
   ObjectSetInteger(_Symbol,"stopLoss", OBJPROP_YDISTANCE, 240);
   ObjectSetInteger(_Symbol,"stopLoss", OBJPROP_YSIZE, 20);
   ObjectSetInteger(_Symbol,"stopLoss", OBJPROP_CORNER, 2);
   ObjectSetInteger(_Symbol,"stopLoss", OBJPROP_BGCOLOR, clrAqua);
   
   //Volume input
   ObjectCreate(_Symbol,"volume",OBJ_EDIT,0,0,0);
   
   ObjectSetInteger(_Symbol,"volume", OBJPROP_XDISTANCE, 930);
   ObjectSetInteger(_Symbol,"volume", OBJPROP_XSIZE, 100);
   ObjectSetInteger(_Symbol,"volume", OBJPROP_YDISTANCE, 300);
   ObjectSetInteger(_Symbol,"volume", OBJPROP_YSIZE, 20);
   ObjectSetInteger(_Symbol,"volume", OBJPROP_CORNER, 2);  
   //ObjectSetString(_Symbol,"volume", OBJPROP_TEXT, "");
   ObjectSetInteger(_Symbol,"volume", OBJPROP_BGCOLOR, clrAqua);
     
   
   //sl text text
   ObjectCreate(_Symbol, "stopLossText", OBJ_LABEL,0,0,0);
   
   ObjectSetString(_Symbol,"stopLossText", OBJPROP_FONT, "Arial Bold");
   ObjectSetInteger(_Symbol,"stopLossText", OBJPROP_FONTSIZE, 10);
   ObjectSetString(_Symbol,"stopLossText", OBJPROP_TEXT, 0, "SL Points");
   ObjectSetInteger(_Symbol,"stopLossText", OBJPROP_XDISTANCE, 10);
   ObjectSetInteger(_Symbol,"stopLossText", OBJPROP_YDISTANCE, 140);
   ObjectSetInteger(_Symbol,"stopLossText", OBJPROP_COLOR, clrWhite);
   
   
   //TP points text
   ObjectCreate(_Symbol, "TPointsText", OBJ_LABEL,0,0,0);
   
   ObjectSetString(_Symbol,"TPointsText", OBJPROP_FONT, "Arial Bold");
   ObjectSetInteger(_Symbol,"TPointsText", OBJPROP_FONTSIZE, 10);
   ObjectSetString(_Symbol, "TPointsText", OBJPROP_TEXT, 0, "TP points");
   ObjectSetInteger(_Symbol, "TPointsText", OBJPROP_XDISTANCE, 10);
   ObjectSetInteger(_Symbol, "TPointsText", OBJPROP_YDISTANCE, 110);
   ObjectSetInteger(_Symbol, "TPointsText", OBJPROP_COLOR, clrWhite);
   
   // Volume text input
   
   ObjectCreate(_Symbol, "VolumeText", OBJ_LABEL,0,0,0);
   
   ObjectSetString(_Symbol,"VolumeText", OBJPROP_FONT, "Arial Bold");
   ObjectSetInteger(_Symbol,"VolumeText", OBJPROP_FONTSIZE, 10);
   ObjectSetString(_Symbol, "VolumeText", OBJPROP_TEXT, 0, "Volume");
   ObjectSetInteger(_Symbol, "VolumeText", OBJPROP_XDISTANCE, 10);
   ObjectSetInteger(_Symbol, "VolumeText", OBJPROP_YDISTANCE, 80);
   ObjectSetInteger(_Symbol, "VolumeText", OBJPROP_COLOR, clrWhite);
   
   //Ask price indicator 
   ObjectCreate(_Symbol, "Ask", OBJ_LABEL,0,0,0);
   
   ObjectSetString(_Symbol,"Ask", OBJPROP_FONT, "Arial Bold");
   ObjectSetInteger(_Symbol,"Ask", OBJPROP_FONTSIZE, 10);
   ObjectSetString(_Symbol, "Ask", OBJPROP_TEXT, 0, "Ask " + Ask);
   ObjectSetInteger(_Symbol, "Ask", OBJPROP_XDISTANCE, 10);
   ObjectSetInteger(_Symbol, "Ask", OBJPROP_YDISTANCE, 190);
   ObjectSetInteger(_Symbol, "Ask", OBJPROP_COLOR, clrGreenYellow);
   
   //Bid price indicator
   ObjectCreate(_Symbol, "Bid", OBJ_LABEL,0,0,0);
   
   ObjectSetString(_Symbol,"Bid", OBJPROP_FONT, "Arial Bold");
   ObjectSetInteger(_Symbol,"Bid", OBJPROP_FONTSIZE, 10);
   ObjectSetString(_Symbol, "Bid", OBJPROP_TEXT, 0, "Bid " + Bid);
   ObjectSetInteger(_Symbol, "Bid", OBJPROP_XDISTANCE, 10);
   ObjectSetInteger(_Symbol, "Bid", OBJPROP_YDISTANCE, 210);
   ObjectSetInteger(_Symbol, "Bid", OBJPROP_COLOR, clrPink);
   
   
   
   
   //spread price indicator
   int currentSpreadPoints = SymbolInfoInteger(Symbol(), SYMBOL_SPREAD);
   
   ObjectCreate(_Symbol, "spread", OBJ_LABEL,0,0,0);
   
   ObjectSetString(_Symbol,"spread", OBJPROP_FONT, "Arial");
   ObjectSetInteger(_Symbol,"spread", OBJPROP_FONTSIZE, 15);
   ObjectSetString(_Symbol, "spread", OBJPROP_TEXT, 0, "Spread: " + currentSpreadPoints);
   ObjectSetInteger(_Symbol, "spread", OBJPROP_XDISTANCE, 10);
   ObjectSetInteger(_Symbol, "spread", OBJPROP_YDISTANCE, 280);
   ObjectSetInteger(_Symbol, "spread", OBJPROP_COLOR, clrYellow);
   
   //Trend text
   ObjectCreate(_Symbol, "trend", OBJ_LABEL,0,0,0);
   
   ObjectSetString(_Symbol,"trend", OBJPROP_FONT, "Arial Bold");
   ObjectSetInteger(_Symbol,"trend", OBJPROP_FONTSIZE, 15);
   ObjectSetString(_Symbol, "trend", OBJPROP_TEXT, 0, "Trend: ");
   ObjectSetInteger(_Symbol, "trend", OBJPROP_XDISTANCE, 10);
   ObjectSetInteger(_Symbol, "trend", OBJPROP_YDISTANCE, 330);
   ObjectSetInteger(_Symbol, "trend", OBJPROP_COLOR, clrWhite);
   
   //Trend indicator
   ObjectCreate(_Symbol, "bs", OBJ_LABEL,0,0,0);
   
   ObjectSetString(_Symbol,"bs", OBJPROP_FONT, "Arial Bold");
   ObjectSetInteger(_Symbol,"bs", OBJPROP_FONTSIZE, 15);
   ObjectSetInteger(_Symbol, "bs", OBJPROP_XDISTANCE, 80);
   ObjectSetInteger(_Symbol, "bs", OBJPROP_YDISTANCE, 330);
   
   if(MovingAverage(1,0) > MovingAverage(200,0)){
      ObjectSetString(_Symbol, "bs", OBJPROP_TEXT, 0, "BULL");
      ObjectSetInteger(_Symbol, "bs", OBJPROP_COLOR, clrGreenYellow);
   }
   if(MovingAverage(5,0) < MovingAverage(200,0)){
      ObjectSetString(_Symbol, "bs", OBJPROP_TEXT, 0, "BEAR");
      ObjectSetInteger(_Symbol, "bs", OBJPROP_COLOR, clrPink);
   }  
   
   if(OrdersTotal() == 1 && PositionsTotal()==0){
      CancelOrder();
   }
   
   BgPanel();
   
}

double GetVolume(double TP, double sl, double volume){ 
   //New volume is tp points divided by sl points times the primary volume
   double NewVolume = (TP/sl)*volume;
   
   return NormalizeDouble(NewVolume + (NewVolume/2),2);
   
}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam){
   if(id == CHARTEVENT_OBJECT_CLICK){
      string ClickedObjectName = sparam;
      if(sparam == "Buy Button"){
         //trade.Buy(0.01,_Symbol,Ask,0,0,NULL);
         string TP;
         string sl;
         string volume;
         ObjectGetString(_Symbol,"TP points",OBJPROP_TEXT,0,TP);
         ObjectGetString(_Symbol,"stopLoss",OBJPROP_TEXT,0,sl);
         ObjectGetString(_Symbol,"volume", OBJPROP_TEXT,0,volume);
         trade.Buy(double(volume),_Symbol,Ask,Ask -((int(TP)*2) * _Point) ,Ask +(int(TP) * _Point),NULL);
         trade.SellStop(GetVolume(TP, sl, volume),(Bid - (int(sl)) * _Point),_Symbol,(Bid + (int(TP)) * _Point),(Bid - (int(TP)*2) * _Point),ORDER_TIME_GTC,0,NULL);
      }
      
      if(sparam == "Sell Button"){
         string TP;
         string sl;
         string volume;
         ObjectGetString(_Symbol,"TP points",OBJPROP_TEXT,0,TP);
         ObjectGetString(_Symbol,"stopLoss",OBJPROP_TEXT,0,sl);
         ObjectGetString(_Symbol,"volume", OBJPROP_TEXT,0,volume);
         trade.Sell(double(volume),_Symbol, Bid, Bid + (int(TP)*2) * _Point, Bid - (int(TP) * _Point),NULL);
         trade.BuyStop(GetVolume(TP, sl, volume), Ask + (int(sl) * _Point), _Symbol, Ask - (int(TP) * _Point), Ask + ((int(TP)*2) * _Point),ORDER_TIME_GTC,0,NULL); 
         //AlertErrors(); 
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

void AlertErrors(){
   if(GetLastError() == 5040){      
      Alert("Invalid volume! please set volume accordingly");
   }
}

void BgPanel(){
   ObjectCreate(0,"R", OBJ_RECTANGLE_LABEL,0,0,0);
   ObjectSetInteger(0,"R", OBJPROP_XDISTANCE,0);
   ObjectSetInteger(0,"R", OBJPROP_YDISTANCE,0);
   ObjectSetInteger(0,"R", OBJPROP_XSIZE, 250);
   ObjectSetInteger(0,"R", OBJPROP_YSIZE, 500);
   ObjectSetInteger(0,"R",OBJPROP_BGCOLOR, clrDarkBlue);
   ObjectSetInteger(0,"R", OBJPROP_FILL, true);
   ObjectSetInteger(0,"R",OBJPROP_BACK,true);

}

double MovingAverage(int MA, int candle){
   double MovingAverageArray[];
   int MovingAverageDefinition = iMA(_Symbol,_Period,MA,0,MODE_EMA,PRICE_CLOSE);
   ArraySetAsSeries(MovingAverageArray, true);
   CopyBuffer(MovingAverageDefinition,0,0,20,MovingAverageArray);
   double MovingAverageValue = NormalizeDouble(MovingAverageArray[candle], _Digits);
   
   return MovingAverageValue;
}