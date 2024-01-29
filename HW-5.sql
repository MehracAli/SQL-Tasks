CREATE TRIGGER ShippersTrigger
ON Shippers
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted) 
    BEGIN
        PRINT 'Save operation';
    END;

    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted) 
    BEGIN
        PRINT 'Update operation';
    END;

    IF NOT EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted) 
    BEGIN
        PRINT 'Delete operation';
    END;
END;
