CREATE FUNCTION AgeCheck(@birhtDate date, @age int)
RETURNS nvarchar(max) 
AS
BEGIN
    DECLARE @message nvarchar(max);

    SET @message = 
        IIF(
            YEAR(GETDATE()) - YEAR(@birhtDate) = @age AND
            MONTH(GETDATE()) - MONTH(@birhtDate) != 0,
            'Yıl olarak doldurmuştur, ay ve gün olarak doldurmamıştır',
            
            IIF(
                YEAR(GETDATE()) - YEAR(@birhtDate) = @age AND
                MONTH(GETDATE()) - MONTH(@birhtDate) = 0 AND
                DAY(GETDATE()) < DAY(@birhtDate),
                'Yıl ve ay olarak doldurmuştur, gün olarak doldurmamıştır',
                
                IIF(
                    YEAR(GETDATE()) - YEAR(@birhtDate) < @age,
                    'Kişi henüz yıl, ay ve gün olarak yaşını doldurmamıştır',
                    'Yaşı tam doldurmuştur'
                )
            )
        );

    RETURN @message;
END


Select FirstName,
       BirthDate,
	   dbo.AgeCheck(BirthDate,61) CheckAge  
from Employees