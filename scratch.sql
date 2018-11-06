show columns from produnit_unit;

select distinct name, name_price,name_plural,name_package_dimension,name_in_package from produnit_unit where isSaleBase <> 1;