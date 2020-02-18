PROGRAM SelectSort(INPUT, OUTPUT);
{—ортирует символы, предшествующие #, из INPUT в OUTPUT.
 ѕрограмма выдаст ошибку, если в INPUT отсутствует #}
VAR
  Ch, Min: CHAR;
  F1, F2: TEXT;
BEGIN {SelectSort}
  BEGIN { опировать INPUT в F1 и эхо в OUTPUT}
    REWRITE(F1); 
    WRITE(OUTPUT, 'INPUT DATA:');
    READ(INPUT, Ch);
    WHILE Ch <> '#'
    DO
      BEGIN
        WRITE(F1, Ch);
        WRITE(OUTPUT, Ch);
        READ(INPUT, Ch)
      END;
    WRITELN(OUTPUT);
    WRITELN(F1, '#')
  END;{ опировать INPUT в F1 и эхо в OUTPUT}
  BEGIN {—ортировать F1 в OUTPUT, использу€ стратегию SelectSort}
    WRITE(OUTPUT, 'SORTED DATA:');
    RESET(F1);
    READ(F1, Ch);
    WHILE Ch <> '#'
    DO { Ch <> С#Т и Ch1 Ц первый символ F1}
      BEGIN
        BEGIN {¬ыбираем минимальный из F1 и копируем остаток F1 в F2}
          REWRITE(F2);
          Min := Ch;
          READ(F1, Ch);
          WHILE Ch <> '#'
          DO { Ch <> С#Т и Ch1 Ц первый символ F1}
            BEGIN
              BEGIN {¬ыбираем минимальный из (Ch, Min) 
                     копируем второй символ в F2}
                IF Ch < Min
                THEN  {Ch Ц минимальный из (Ch, Min)}
                  BEGIN
                    WRITE(F2, Min);
                    Min := Ch;
                  END
                ELSE {Min Ц минимальный из (Ch, Min)}
                  WRITE(F2, Ch);
              END;
              READ(F1, Ch)
            END;
          WRITELN(F2, '#');
        END;{¬ыбираем минимальный из F1 и копируем остаток F1 в F2}
        WRITE(OUTPUT, Min);
        BEGIN { опируем F2 в F1}
          RESET(F2);
          REWRITE(F1);
          READ(F2, Ch);
          WHILE Ch <> '#'
          DO 
            BEGIN
              WRITE(F1, Ch);
              READ(F2, Ch)
            END;
          WRITELN(F1, '#');
        END;{ опируем F2 в F1}
        RESET(F1);
        READ(F1, Ch)
      END;
    WRITELN(OUTPUT)
  END{—ортировать F1 в OUTPUT, использу€ стратегию SelectSort}
END. {SelectSort}
