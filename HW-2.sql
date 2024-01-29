CREATE PROCEDURE AddCategory
    @category NVARCHAR(255)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = @category)
		BEGIN
			INSERT INTO Categories (CategoryName)
			VALUES (@category)

			PRINT 'Category added'
		END
    ELSE
		BEGIN
			PRINT 'This category already have'
		END
END

EXEC AddCategory 'NewCategory'