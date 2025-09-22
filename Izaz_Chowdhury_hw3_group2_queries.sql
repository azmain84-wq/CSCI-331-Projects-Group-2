{
    "metadata": {
        "kernelspec": {
            "name": "SQL",
            "display_name": "SQL",
            "language": "sql"
        },
        "language_info": {
            "name": "sql",
            "version": ""
        }
    },
    "nbformat_minor": 2,
    "nbformat": 4,
    "cells": [
        {
            "cell_type": "markdown",
            "source": [
                "> <span style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium;\"><u>1.&nbsp;</u></span> <span style=\"color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium; caret-color: rgb(0, 0, 0);\">Find the top 10 customers by total sales amount</span>\n",
                "\n",
                "<span style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium;\"><br></span>"
            ],
            "metadata": {
                "azdata_cell_guid": "f840d7da-214e-47d0-9228-b2c88f7d40b8"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT TOP 10 \n",
                "    c.CustomerID, \n",
                "    c.CustomerName, \n",
                "    SUM(il.ExtendedPrice) AS TotalSales\n",
                "FROM Sales.Customers AS c\n",
                "JOIN Sales.Invoices AS i\n",
                "    ON c.CustomerID = i.CustomerID\n",
                "JOIN Sales.InvoiceLines AS il\n",
                "    ON i.InvoiceID = il.InvoiceID\n",
                "GROUP BY c.CustomerID, c.CustomerName\n",
                "ORDER BY TotalSales DESC;\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "b35ba17e-20f7-4ec3-b52e-5e0af768d033",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(10 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.096"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 2,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "CustomerID"
                                    },
                                    {
                                        "name": "CustomerName"
                                    },
                                    {
                                        "name": "TotalSales"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "CustomerID": "149",
                                    "CustomerName": "Tailspin Toys (Inguadona, MN)",
                                    "TotalSales": "438689.81"
                                },
                                {
                                    "CustomerID": "132",
                                    "CustomerName": "Tailspin Toys (Minidoka, ID)",
                                    "TotalSales": "427445.57"
                                },
                                {
                                    "CustomerID": "977",
                                    "CustomerName": "Mauno Laurila",
                                    "TotalSales": "424324.76"
                                },
                                {
                                    "CustomerID": "580",
                                    "CustomerName": "Wingtip Toys (Sarversville, PA)",
                                    "TotalSales": "420001.08"
                                },
                                {
                                    "CustomerID": "954",
                                    "CustomerName": "Nasrin Omidzadeh",
                                    "TotalSales": "416005.03"
                                },
                                {
                                    "CustomerID": "14",
                                    "CustomerName": "Tailspin Toys (Long Meadow, MD)",
                                    "TotalSales": "414934.18"
                                },
                                {
                                    "CustomerID": "964",
                                    "CustomerName": "Ingrida Zeltina",
                                    "TotalSales": "413817.88"
                                },
                                {
                                    "CustomerID": "472",
                                    "CustomerName": "Wingtip Toys (San Jacinto, CA)",
                                    "TotalSales": "408524.95"
                                },
                                {
                                    "CustomerID": "996",
                                    "CustomerName": "Laszlo Gardenier",
                                    "TotalSales": "407800.89"
                                },
                                {
                                    "CustomerID": "841",
                                    "CustomerName": "Camille Authier",
                                    "TotalSales": "406493.27"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>CustomerID</th><th>CustomerName</th><th>TotalSales</th></tr>",
                            "<tr><td>149</td><td>Tailspin Toys (Inguadona, MN)</td><td>438689.81</td></tr>",
                            "<tr><td>132</td><td>Tailspin Toys (Minidoka, ID)</td><td>427445.57</td></tr>",
                            "<tr><td>977</td><td>Mauno Laurila</td><td>424324.76</td></tr>",
                            "<tr><td>580</td><td>Wingtip Toys (Sarversville, PA)</td><td>420001.08</td></tr>",
                            "<tr><td>954</td><td>Nasrin Omidzadeh</td><td>416005.03</td></tr>",
                            "<tr><td>14</td><td>Tailspin Toys (Long Meadow, MD)</td><td>414934.18</td></tr>",
                            "<tr><td>964</td><td>Ingrida Zeltina</td><td>413817.88</td></tr>",
                            "<tr><td>472</td><td>Wingtip Toys (San Jacinto, CA)</td><td>408524.95</td></tr>",
                            "<tr><td>996</td><td>Laszlo Gardenier</td><td>407800.89</td></tr>",
                            "<tr><td>841</td><td>Camille Authier</td><td>406493.27</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 2
        },
        {
            "cell_type": "markdown",
            "source": [
                "<span style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium;\">2.&nbsp;</span> <span style=\"color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium; caret-color: rgb(0, 0, 0);\">List the top 5 products that generated the most revenue.</span>\n",
                "\n",
                "<span style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium;\"><br></span>"
            ],
            "metadata": {
                "azdata_cell_guid": "1c3f47a2-9c62-4477-a276-18180141c83a"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT TOP 5 \n",
                "    si.StockItemID, \n",
                "    si.StockItemName, \n",
                "    SUM(il.ExtendedPrice) AS TotalRevenue\n",
                "FROM Warehouse.StockItems AS si\n",
                "JOIN Sales.InvoiceLines AS il\n",
                "    ON si.StockItemID = il.StockItemID\n",
                "GROUP BY si.StockItemID, si.StockItemName\n",
                "ORDER BY TotalRevenue DESC;\n",
                "\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "bc7dcfcb-f816-43a9-b5d8-78732370fe35",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(5 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.052"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 3,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "StockItemID"
                                    },
                                    {
                                        "name": "StockItemName"
                                    },
                                    {
                                        "name": "TotalRevenue"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "StockItemID": "215",
                                    "StockItemName": "Air cushion machine (Blue)",
                                    "TotalRevenue": "12773338.65"
                                },
                                {
                                    "StockItemID": "173",
                                    "StockItemName": "32 mm Anti static bubble wrap (Blue) 50m",
                                    "TotalRevenue": "7341600.00"
                                },
                                {
                                    "StockItemID": "167",
                                    "StockItemName": "10 mm Anti static bubble wrap (Blue) 50m",
                                    "TotalRevenue": "7278430.50"
                                },
                                {
                                    "StockItemID": "161",
                                    "StockItemName": "20 mm Double sided bubble wrap 50m",
                                    "TotalRevenue": "7146468.00"
                                },
                                {
                                    "StockItemID": "164",
                                    "StockItemName": "32 mm Double sided bubble wrap 50m",
                                    "TotalRevenue": "7118776.00"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>StockItemID</th><th>StockItemName</th><th>TotalRevenue</th></tr>",
                            "<tr><td>215</td><td>Air cushion machine (Blue)</td><td>12773338.65</td></tr>",
                            "<tr><td>173</td><td>32 mm Anti static bubble wrap (Blue) 50m</td><td>7341600.00</td></tr>",
                            "<tr><td>167</td><td>10 mm Anti static bubble wrap (Blue) 50m</td><td>7278430.50</td></tr>",
                            "<tr><td>161</td><td>20 mm Double sided bubble wrap 50m</td><td>7146468.00</td></tr>",
                            "<tr><td>164</td><td>32 mm Double sided bubble wrap 50m</td><td>7118776.00</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 3
        },
        {
            "cell_type": "markdown",
            "source": [
                "<span style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium;\">3. Find the top 5 salespeople by total number of invoices they handled.</span>"
            ],
            "metadata": {
                "azdata_cell_guid": "70f717da-d610-4103-9340-cf7f9fcbed47"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT TOP 5 \n",
                "    sp.PersonID, \n",
                "    sp.FullName, \n",
                "    COUNT(i.InvoiceID) AS TotalInvoices\n",
                "FROM Application.People AS sp\n",
                "JOIN Sales.Invoices AS i\n",
                "    ON sp.PersonID = i.SalespersonPersonID\n",
                "GROUP BY sp.PersonID, sp.FullName\n",
                "ORDER BY TotalInvoices DESC;\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "4d178afc-b218-45d1-86bf-23a62ecebade",
                "language": "sql",
                "tags": []
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(5 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.019"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 4,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "PersonID"
                                    },
                                    {
                                        "name": "FullName"
                                    },
                                    {
                                        "name": "TotalInvoices"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "PersonID": "16",
                                    "FullName": "Archer Lamble",
                                    "TotalInvoices": "7184"
                                },
                                {
                                    "PersonID": "2",
                                    "FullName": "Kayla Woodcock",
                                    "TotalInvoices": "7160"
                                },
                                {
                                    "PersonID": "13",
                                    "FullName": "Hudson Hollinworth",
                                    "TotalInvoices": "7079"
                                },
                                {
                                    "PersonID": "15",
                                    "FullName": "Taj Shand",
                                    "TotalInvoices": "7074"
                                },
                                {
                                    "PersonID": "6",
                                    "FullName": "Sophia Hinton",
                                    "TotalInvoices": "7073"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>PersonID</th><th>FullName</th><th>TotalInvoices</th></tr>",
                            "<tr><td>16</td><td>Archer Lamble</td><td>7184</td></tr>",
                            "<tr><td>2</td><td>Kayla Woodcock</td><td>7160</td></tr>",
                            "<tr><td>13</td><td>Hudson Hollinworth</td><td>7079</td></tr>",
                            "<tr><td>15</td><td>Taj Shand</td><td>7074</td></tr>",
                            "<tr><td>6</td><td>Sophia Hinton</td><td>7073</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 4
        },
        {
            "cell_type": "markdown",
            "source": [
                "<span style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium;\">4. List the top 5 products that generated the most revenue.</span>"
            ],
            "metadata": {
                "azdata_cell_guid": "bbccc7db-6d0e-4d0f-a7f0-3a205f633562"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT TOP 10 \n",
                "    ct.CityName, \n",
                "    COUNT(c.CustomerID) AS NumCustomers\n",
                "FROM Sales.Customers AS c\n",
                "JOIN Application.Cities AS ct\n",
                "    ON c.DeliveryCityID = ct.CityID\n",
                "GROUP BY ct.CityName\n",
                "ORDER BY NumCustomers DESC;"
            ],
            "metadata": {
                "azdata_cell_guid": "70b32de4-24f6-45cf-9ccb-5b74d84b3881",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(10 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.026"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 5,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "CityName"
                                    },
                                    {
                                        "name": "NumCustomers"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "CityName": "Akhiok",
                                    "NumCustomers": "2"
                                },
                                {
                                    "CityName": "Cherry Grove Beach",
                                    "NumCustomers": "2"
                                },
                                {
                                    "CityName": "East Fultonham",
                                    "NumCustomers": "2"
                                },
                                {
                                    "CityName": "Isabela",
                                    "NumCustomers": "2"
                                },
                                {
                                    "CityName": "Palmas del Mar",
                                    "NumCustomers": "2"
                                },
                                {
                                    "CityName": "Rockwall",
                                    "NumCustomers": "2"
                                },
                                {
                                    "CityName": "Sinclair",
                                    "NumCustomers": "2"
                                },
                                {
                                    "CityName": "Teutopolis",
                                    "NumCustomers": "2"
                                },
                                {
                                    "CityName": "Amanda Park",
                                    "NumCustomers": "1"
                                },
                                {
                                    "CityName": "Amado",
                                    "NumCustomers": "1"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>CityName</th><th>NumCustomers</th></tr>",
                            "<tr><td>Akhiok</td><td>2</td></tr>",
                            "<tr><td>Cherry Grove Beach</td><td>2</td></tr>",
                            "<tr><td>East Fultonham</td><td>2</td></tr>",
                            "<tr><td>Isabela</td><td>2</td></tr>",
                            "<tr><td>Palmas del Mar</td><td>2</td></tr>",
                            "<tr><td>Rockwall</td><td>2</td></tr>",
                            "<tr><td>Sinclair</td><td>2</td></tr>",
                            "<tr><td>Teutopolis</td><td>2</td></tr>",
                            "<tr><td>Amanda Park</td><td>1</td></tr>",
                            "<tr><td>Amado</td><td>1</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 5
        },
        {
            "cell_type": "markdown",
            "source": [
                "<span style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium;\">5. List the top 10 customers with the highest number of orders (invoices).</span>"
            ],
            "metadata": {
                "azdata_cell_guid": "a23337df-bc88-4fa8-908d-4fb1b6ec6c4c"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT TOP 10 \n",
                "    c.CustomerID, \n",
                "    c.CustomerName, \n",
                "    COUNT(i.InvoiceID) AS TotalOrders\n",
                "FROM Sales.Customers AS c\n",
                "JOIN Sales.Invoices AS i\n",
                "    ON c.CustomerID = i.CustomerID\n",
                "GROUP BY c.CustomerID, c.CustomerName\n",
                "ORDER BY TotalOrders DESC;\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "42caf06d-d330-412e-b71e-457b12b38b7c",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(10 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.022"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 6,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "CustomerID"
                                    },
                                    {
                                        "name": "CustomerName"
                                    },
                                    {
                                        "name": "TotalOrders"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "CustomerID": "831",
                                    "CustomerName": "Bhaavan Rai",
                                    "TotalOrders": "144"
                                },
                                {
                                    "CustomerID": "804",
                                    "CustomerName": "Aleksandrs Riekstins",
                                    "TotalOrders": "139"
                                },
                                {
                                    "CustomerID": "90",
                                    "CustomerName": "Tailspin Toys (Tolna, ND)",
                                    "TotalOrders": "139"
                                },
                                {
                                    "CustomerID": "110",
                                    "CustomerName": "Tailspin Toys (North Crows Nest, IN)",
                                    "TotalOrders": "138"
                                },
                                {
                                    "CustomerID": "968",
                                    "CustomerName": "Anca Gogean",
                                    "TotalOrders": "138"
                                },
                                {
                                    "CustomerID": "405",
                                    "CustomerName": "Wingtip Toys (Bourbonnais, IL)",
                                    "TotalOrders": "137"
                                },
                                {
                                    "CustomerID": "910",
                                    "CustomerName": "Elina Kaleja",
                                    "TotalOrders": "136"
                                },
                                {
                                    "CustomerID": "580",
                                    "CustomerName": "Wingtip Toys (Sarversville, PA)",
                                    "TotalOrders": "136"
                                },
                                {
                                    "CustomerID": "964",
                                    "CustomerName": "Ingrida Zeltina",
                                    "TotalOrders": "135"
                                },
                                {
                                    "CustomerID": "941",
                                    "CustomerName": "Bishwa Chatterjee",
                                    "TotalOrders": "135"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>CustomerID</th><th>CustomerName</th><th>TotalOrders</th></tr>",
                            "<tr><td>831</td><td>Bhaavan Rai</td><td>144</td></tr>",
                            "<tr><td>804</td><td>Aleksandrs Riekstins</td><td>139</td></tr>",
                            "<tr><td>90</td><td>Tailspin Toys (Tolna, ND)</td><td>139</td></tr>",
                            "<tr><td>110</td><td>Tailspin Toys (North Crows Nest, IN)</td><td>138</td></tr>",
                            "<tr><td>968</td><td>Anca Gogean</td><td>138</td></tr>",
                            "<tr><td>405</td><td>Wingtip Toys (Bourbonnais, IL)</td><td>137</td></tr>",
                            "<tr><td>910</td><td>Elina Kaleja</td><td>136</td></tr>",
                            "<tr><td>580</td><td>Wingtip Toys (Sarversville, PA)</td><td>136</td></tr>",
                            "<tr><td>964</td><td>Ingrida Zeltina</td><td>135</td></tr>",
                            "<tr><td>941</td><td>Bishwa Chatterjee</td><td>135</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 6
        },
        {
            "cell_type": "markdown",
            "source": [
                "<span style=\"color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium; caret-color: rgb(0, 0, 0);\">Show the top 5 suppliers by the total value of products supplied.</span>"
            ],
            "metadata": {
                "azdata_cell_guid": "414835f3-7fe7-4168-92e7-b20349b084e0"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT TOP 5 \n",
                "    s.SupplierID, \n",
                "    s.SupplierName, \n",
                "    SUM(pol.ReceivedOuters * pol.ExpectedUnitPricePerOuter) AS TotalSuppliedValue\n",
                "FROM Purchasing.Suppliers AS s\n",
                "JOIN Purchasing.PurchaseOrders AS po\n",
                "    ON s.SupplierID = po.SupplierID\n",
                "JOIN Purchasing.PurchaseOrderLines AS pol\n",
                "    ON po.PurchaseOrderID = pol.PurchaseOrderID\n",
                "GROUP BY s.SupplierID, s.SupplierName\n",
                "ORDER BY TotalSuppliedValue DESC;\n",
                "\n",
                "\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "778213db-22c7-434e-82fc-e3558f83dcb8",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(5 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.052"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 14,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "SupplierID"
                                    },
                                    {
                                        "name": "SupplierName"
                                    },
                                    {
                                        "name": "TotalSuppliedValue"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "SupplierID": "4",
                                    "SupplierName": "Fabrikam, Inc.",
                                    "TotalSuppliedValue": "678066222.00"
                                },
                                {
                                    "SupplierID": "7",
                                    "SupplierName": "Litware, Inc.",
                                    "TotalSuppliedValue": "266115587.90"
                                },
                                {
                                    "SupplierID": "10",
                                    "SupplierName": "Northwind Electric Cars",
                                    "TotalSuppliedValue": "78816.50"
                                },
                                {
                                    "SupplierID": "12",
                                    "SupplierName": "The Phone Company",
                                    "TotalSuppliedValue": "50820.00"
                                },
                                {
                                    "SupplierID": "1",
                                    "SupplierName": "A Datum Corporation",
                                    "TotalSuppliedValue": "25023.00"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>SupplierID</th><th>SupplierName</th><th>TotalSuppliedValue</th></tr>",
                            "<tr><td>4</td><td>Fabrikam, Inc.</td><td>678066222.00</td></tr>",
                            "<tr><td>7</td><td>Litware, Inc.</td><td>266115587.90</td></tr>",
                            "<tr><td>10</td><td>Northwind Electric Cars</td><td>78816.50</td></tr>",
                            "<tr><td>12</td><td>The Phone Company</td><td>50820.00</td></tr>",
                            "<tr><td>1</td><td>A Datum Corporation</td><td>25023.00</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 14
        },
        {
            "cell_type": "markdown",
            "source": [
                "<span style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium;\">Find the 10 most frequently purchased stock items.</span>"
            ],
            "metadata": {
                "azdata_cell_guid": "96829f79-a0f7-4097-bba9-911923b486a8"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT TOP 10 \n",
                "    si.StockItemID, \n",
                "    si.StockItemName, \n",
                "    COUNT(il.InvoiceLineID) AS TimesPurchased\n",
                "FROM Warehouse.StockItems AS si\n",
                "JOIN Sales.InvoiceLines AS il\n",
                "    ON si.StockItemID = il.StockItemID\n",
                "GROUP BY si.StockItemID, si.StockItemName\n",
                "ORDER BY TimesPurchased DESC;\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "b1184a4d-dafd-453f-abdc-804f3dc10b09",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(10 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.052"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 11,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "StockItemID"
                                    },
                                    {
                                        "name": "StockItemName"
                                    },
                                    {
                                        "name": "TimesPurchased"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "StockItemID": "120",
                                    "StockItemName": "Dinosaur battery-powered slippers (Green) L",
                                    "TimesPurchased": "1123"
                                },
                                {
                                    "StockItemID": "104",
                                    "StockItemName": "Alien officer hoodie (Black) 3XL",
                                    "TimesPurchased": "1123"
                                },
                                {
                                    "StockItemID": "167",
                                    "StockItemName": "10 mm Anti static bubble wrap (Blue) 50m",
                                    "TimesPurchased": "1119"
                                },
                                {
                                    "StockItemID": "13",
                                    "StockItemName": "USB food flash drive - shrimp cocktail",
                                    "TimesPurchased": "1117"
                                },
                                {
                                    "StockItemID": "160",
                                    "StockItemName": "20 mm Double sided bubble wrap 20m",
                                    "TimesPurchased": "1110"
                                },
                                {
                                    "StockItemID": "88",
                                    "StockItemName": "\"The Gu\" red shirt XML tag t-shirt (White) 7XL",
                                    "TimesPurchased": "1110"
                                },
                                {
                                    "StockItemID": "137",
                                    "StockItemName": "Animal with big feet slippers (Brown) XL",
                                    "TimesPurchased": "1108"
                                },
                                {
                                    "StockItemID": "165",
                                    "StockItemName": "10 mm Anti static bubble wrap (Blue) 10m",
                                    "TimesPurchased": "1104"
                                },
                                {
                                    "StockItemID": "74",
                                    "StockItemName": "Ride on vintage American toy coupe (Black) 1/12 scale",
                                    "TimesPurchased": "1103"
                                },
                                {
                                    "StockItemID": "28",
                                    "StockItemName": "DBA joke mug - two types of DBAs (White)",
                                    "TimesPurchased": "1102"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>StockItemID</th><th>StockItemName</th><th>TimesPurchased</th></tr>",
                            "<tr><td>120</td><td>Dinosaur battery-powered slippers (Green) L</td><td>1123</td></tr>",
                            "<tr><td>104</td><td>Alien officer hoodie (Black) 3XL</td><td>1123</td></tr>",
                            "<tr><td>167</td><td>10 mm Anti static bubble wrap (Blue) 50m</td><td>1119</td></tr>",
                            "<tr><td>13</td><td>USB food flash drive - shrimp cocktail</td><td>1117</td></tr>",
                            "<tr><td>160</td><td>20 mm Double sided bubble wrap 20m</td><td>1110</td></tr>",
                            "<tr><td>88</td><td>&quot;The Gu&quot; red shirt XML tag t-shirt (White) 7XL</td><td>1110</td></tr>",
                            "<tr><td>137</td><td>Animal with big feet slippers (Brown) XL</td><td>1108</td></tr>",
                            "<tr><td>165</td><td>10 mm Anti static bubble wrap (Blue) 10m</td><td>1104</td></tr>",
                            "<tr><td>74</td><td>Ride on vintage American toy coupe (Black) 1/12 scale</td><td>1103</td></tr>",
                            "<tr><td>28</td><td>DBA joke mug - two types of DBAs (White)</td><td>1102</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 11
        },
        {
            "cell_type": "markdown",
            "source": [
                "<span style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium;\">Show the 5 customers with the highest total purchase value.</span>"
            ],
            "metadata": {
                "azdata_cell_guid": "018cdbd6-d59c-4366-b781-03ab42278b79"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT TOP 5 \n",
                "    c.CustomerID, \n",
                "    c.CustomerName, \n",
                "    SUM(il.ExtendedPrice) AS TotalSpent\n",
                "FROM Sales.Customers AS c\n",
                "JOIN Sales.Invoices AS i\n",
                "    ON c.CustomerID = i.CustomerID\n",
                "JOIN Sales.InvoiceLines AS il\n",
                "    ON i.InvoiceID = il.InvoiceID\n",
                "GROUP BY c.CustomerID, c.CustomerName\n",
                "ORDER BY TotalSpent DESC;\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "1c8c6576-733a-4eb7-bf0f-12fff53a1cb4",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(5 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.114"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 10,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "CustomerID"
                                    },
                                    {
                                        "name": "CustomerName"
                                    },
                                    {
                                        "name": "TotalSpent"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "CustomerID": "149",
                                    "CustomerName": "Tailspin Toys (Inguadona, MN)",
                                    "TotalSpent": "438689.81"
                                },
                                {
                                    "CustomerID": "132",
                                    "CustomerName": "Tailspin Toys (Minidoka, ID)",
                                    "TotalSpent": "427445.57"
                                },
                                {
                                    "CustomerID": "977",
                                    "CustomerName": "Mauno Laurila",
                                    "TotalSpent": "424324.76"
                                },
                                {
                                    "CustomerID": "580",
                                    "CustomerName": "Wingtip Toys (Sarversville, PA)",
                                    "TotalSpent": "420001.08"
                                },
                                {
                                    "CustomerID": "954",
                                    "CustomerName": "Nasrin Omidzadeh",
                                    "TotalSpent": "416005.03"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>CustomerID</th><th>CustomerName</th><th>TotalSpent</th></tr>",
                            "<tr><td>149</td><td>Tailspin Toys (Inguadona, MN)</td><td>438689.81</td></tr>",
                            "<tr><td>132</td><td>Tailspin Toys (Minidoka, ID)</td><td>427445.57</td></tr>",
                            "<tr><td>977</td><td>Mauno Laurila</td><td>424324.76</td></tr>",
                            "<tr><td>580</td><td>Wingtip Toys (Sarversville, PA)</td><td>420001.08</td></tr>",
                            "<tr><td>954</td><td>Nasrin Omidzadeh</td><td>416005.03</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 10
        },
        {
            "cell_type": "markdown",
            "source": [
                "<span style=\"caret-color: rgb(0, 0, 0); color: rgb(0, 0, 0); font-family: -webkit-standard; font-size: medium;\">List suppliers who provide more than 50 different stock items.</span>"
            ],
            "metadata": {
                "azdata_cell_guid": "b04b811e-c37a-493e-a109-c420f0cae273"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT \n",
                "    s.SupplierID, \n",
                "    s.SupplierName, \n",
                "    COUNT(DISTINCT si.StockItemID) AS ItemsSupplied\n",
                "FROM Purchasing.Suppliers AS s\n",
                "JOIN Warehouse.StockItems AS si\n",
                "    ON s.SupplierID = si.SupplierID\n",
                "GROUP BY s.SupplierID, s.SupplierName\n",
                "HAVING COUNT(DISTINCT si.StockItemID) > 50\n",
                "ORDER BY ItemsSupplied DESC;\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "3c02ca13-4106-45ff-a6ca-3c62e6b715a9",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(2 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.022"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 9,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "SupplierID"
                                    },
                                    {
                                        "name": "SupplierName"
                                    },
                                    {
                                        "name": "ItemsSupplied"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "SupplierID": "4",
                                    "SupplierName": "Fabrikam, Inc.",
                                    "ItemsSupplied": "74"
                                },
                                {
                                    "SupplierID": "7",
                                    "SupplierName": "Litware, Inc.",
                                    "ItemsSupplied": "67"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>SupplierID</th><th>SupplierName</th><th>ItemsSupplied</th></tr>",
                            "<tr><td>4</td><td>Fabrikam, Inc.</td><td>74</td></tr>",
                            "<tr><td>7</td><td>Litware, Inc.</td><td>67</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 9
        },
        {
            "cell_type": "markdown",
            "source": [
                "**Find the top 5 employees by the number of orders they processed.**"
            ],
            "metadata": {
                "azdata_cell_guid": "efc318e8-d33a-4f9d-acf3-ed33196b8795"
            },
            "attachments": {}
        },
        {
            "cell_type": "code",
            "source": [
                "SELECT TOP 5 \n",
                "    e.PersonID, \n",
                "    e.FullName, \n",
                "    COUNT(i.InvoiceID) AS OrdersProcessed\n",
                "FROM Application.People AS e\n",
                "JOIN Sales.Invoices AS i\n",
                "    ON e.PersonID = i.SalespersonPersonID\n",
                "GROUP BY e.PersonID, e.FullName\n",
                "ORDER BY OrdersProcessed DESC;\n",
                ""
            ],
            "metadata": {
                "azdata_cell_guid": "e01d7186-38a2-45d0-a8ac-f25e7a2e63c3",
                "language": "sql"
            },
            "outputs": [
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "(5 rows affected)"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "display_data",
                    "data": {
                        "text/html": "Total execution time: 00:00:00.034"
                    },
                    "metadata": {}
                },
                {
                    "output_type": "execute_result",
                    "metadata": {},
                    "execution_count": 8,
                    "data": {
                        "application/vnd.dataresource+json": {
                            "schema": {
                                "fields": [
                                    {
                                        "name": "PersonID"
                                    },
                                    {
                                        "name": "FullName"
                                    },
                                    {
                                        "name": "OrdersProcessed"
                                    }
                                ]
                            },
                            "data": [
                                {
                                    "PersonID": "16",
                                    "FullName": "Archer Lamble",
                                    "OrdersProcessed": "7184"
                                },
                                {
                                    "PersonID": "2",
                                    "FullName": "Kayla Woodcock",
                                    "OrdersProcessed": "7160"
                                },
                                {
                                    "PersonID": "13",
                                    "FullName": "Hudson Hollinworth",
                                    "OrdersProcessed": "7079"
                                },
                                {
                                    "PersonID": "15",
                                    "FullName": "Taj Shand",
                                    "OrdersProcessed": "7074"
                                },
                                {
                                    "PersonID": "6",
                                    "FullName": "Sophia Hinton",
                                    "OrdersProcessed": "7073"
                                }
                            ]
                        },
                        "text/html": [
                            "<table>",
                            "<tr><th>PersonID</th><th>FullName</th><th>OrdersProcessed</th></tr>",
                            "<tr><td>16</td><td>Archer Lamble</td><td>7184</td></tr>",
                            "<tr><td>2</td><td>Kayla Woodcock</td><td>7160</td></tr>",
                            "<tr><td>13</td><td>Hudson Hollinworth</td><td>7079</td></tr>",
                            "<tr><td>15</td><td>Taj Shand</td><td>7074</td></tr>",
                            "<tr><td>6</td><td>Sophia Hinton</td><td>7073</td></tr>",
                            "</table>"
                        ]
                    }
                }
            ],
            "execution_count": 8
        }
    ]
}