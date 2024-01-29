CREATE PROCEDURE AddProduct
    @CategoryName NVARCHAR(50),
    @Description NVARCHAR(255),
    @ProductName NVARCHAR(100),
    @UnitPrice DECIMAL(10, 2),
    @UnitsInStock INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CategoryId INT;

    IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = @CategoryName)
    BEGIN
        INSERT INTO Categories (CategoryName, Description)
        VALUES (@CategoryName, @Description);

        SET @CategoryId = SCOPE_IDENTITY();
    END
    ELSE
    BEGIN
        SET @CategoryId = (SELECT CategoryID FROM Categories WHERE CategoryName = @CategoryName);
    END

    INSERT INTO Products (ProductName, CategoryID, UnitPrice, UnitsInStock)
    VALUES (@ProductName, @CategoryId, @UnitPrice, @UnitsInStock);
END;

EXEC AddProduct 'NewCategory', 'Desc', 'Product', 100, 10;
