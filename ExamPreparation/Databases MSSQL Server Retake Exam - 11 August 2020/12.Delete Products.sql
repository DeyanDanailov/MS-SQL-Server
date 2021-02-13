
/*create table DeletedProducts
(
     Id          int identity
        primary key,
    Name        nvarchar(25)   not null
        unique,
    Description nvarchar(250),
    Recipe      nvarchar(max)  not null,
    Price       decimal(15, 2) not null
        check ([Price] >= 0)
)*/

create trigger dbo.ProductsToDelete
    on Products
    instead of DELETE
    as
begin
    declare
        @deletedProductId int = (SELECT p.Id
                                 from Products as p
                                          join deleted as d on d.Id = p.Id)
    delete
    from ProductsIngredients
    where ProductId = @deletedProductId
    delete
    from Feedbacks
    where ProductId = @deletedProductId
    delete
    from Products
    where Id = @deletedProductId
end