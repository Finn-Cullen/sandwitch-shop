class PriceCalc {
  int calcprice(int quant,bool type){
    int p = 7;
    if(type){p = 11;}
    return p*quant;
  }
}
