UNIT Date1;
INTERFACE
  TYPE
    Month = (NoMonth, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep,
    Oct, Nov, Dec);
  PROCEDURE ReadMonth(VAR FIn: TEXT; VAR Mo: Month); {„итает мес€ц из FIn}
  PROCEDURE WriteMonth(VAR FOut: TEXT; VAR Mo: Month); {ѕишет мес€ц в FOut}
  
IMPLEMENTATION
  PROCEDURE ReadMonth(VAR FIn: TEXT; VAR Mo: Month);
  {FIn = R и length(FIn) >= 3 -> читать три символа из FIn, затем присвоить Mo 
  соответствующее значение типа Month, если это возможно, иначе присвоить Mo 
  значение NoMonth}
  VAR
    Ch1, Ch2, Ch3: CHAR;
  BEGIN{ReadMonth}
    READ(FIn, Ch1, Ch2, Ch3);
    IF (Ch1 = 'J') AND (Ch2 = 'A') AND (Ch3 = 'N') THEN Mo := Jan ELSE
    IF (Ch1 = 'F') AND (Ch2 = 'E') AND (Ch3 = 'B') THEN Mo := Feb ELSE
    IF (Ch1 = 'M') AND (Ch2 = 'A') AND (Ch3 = 'R') THEN Mo := Mar ELSE
    IF (Ch1 = 'A') AND (Ch2 = 'P') AND (Ch3 = 'R') THEN Mo := Apr ELSE
    IF (Ch1 = 'M') AND (Ch2 = 'A') AND (Ch3 = 'Y') THEN Mo := May ELSE
    IF (Ch1 = 'J') AND (Ch2 = 'U') AND (Ch3 = 'N') THEN Mo := Jun ELSE
    IF (Ch1 = 'J') AND (Ch2 = 'U') AND (Ch3 = 'L') THEN Mo := Jul ELSE
    IF (Ch1 = 'A') AND (Ch2 = 'U') AND (Ch3 = 'G') THEN Mo := Aug ELSE
    IF (Ch1 = 'S') AND (Ch2 = 'E') AND (Ch3 = 'P') THEN Mo := Sep ELSE
    IF (Ch1 = 'O') AND (Ch2 = 'C') AND (Ch3 = 'T') THEN Mo := Oct ELSE
    IF (Ch1 = 'N') AND (Ch2 = 'O') AND (Ch3 = 'V') THEN Mo := Nov ELSE
    IF (Ch1 = 'D') AND (Ch2 = 'E') AND (Ch3 = 'C') THEN Mo := Dec ELSE 
    Mo := NoMonth
  END;  {ReadMonth}
  
  PROCEDURE WriteMonth(VAR FOut: TEXT; VAR Mo: Month);
  {FIn = W и Mo <> NoMonth -> вывести три символа соответствующие 
  значению Mo, в FOut}
  BEGIN {WriteMonth}
    IF Mo = Jan THEN WRITE(FOut, 'Jan') ELSE
    IF Mo = Feb THEN WRITE(FOut, 'Feb') ELSE
    IF Mo = Mar THEN WRITE(FOut, 'Mar') ELSE
    IF Mo = Apr THEN WRITE(FOut, 'Apr') ELSE
    IF Mo = May THEN WRITE(FOut, 'May') ELSE
    IF Mo = Jun THEN WRITE(FOut, 'Jun') ELSE
    IF Mo = Jul THEN WRITE(FOut, 'Jul') ELSE
    IF Mo = Aug THEN WRITE(FOut, 'Aug') ELSE
    IF Mo = Sep THEN WRITE(FOut, 'Sep') ELSE
    IF Mo = Oct THEN WRITE(FOut, 'Oct') ELSE
    IF Mo = Nov THEN WRITE(FOut, 'Nov') ELSE
    IF Mo = Dec THEN WRITE(FOut, 'Dec')
  END;  {WriteMonth}
BEGIN{Date1}
END.{Date1}     
