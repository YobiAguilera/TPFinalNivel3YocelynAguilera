<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Favoritos.aspx.cs" Inherits="catalogo_web.Favoritos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 100vw;
            margin: auto;
            overflow: hidden;
        }

        .row {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            margin-bottom: 20px;
        }

        .col {
            width: 100vw;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            text-align: center;
        }

        .card {
            border: 1px solid #ccc;
            border-radius: 8px;
            overflow: hidden;
        }

        .card-body {
            padding: 20px;
        }

        .card-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .card-text {
            margin-bottom: 10px;
        }

        .btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
        }

            .btn:hover {
                background-color: #0056b3;
            }

        .imgProducto {
            width: 300px;
            height: 300px;
        }

        @media only screen and (max-width: 768px) {
            .col {
                width: 100%;
                margin-bottom: 20px;
            }
        }

        .btn-primary {
            background-color: #D7CCC8;
            border-color: #BCAAA4;
        }

            .btn-primary:hover {
                background-color: #BCAAA4;
                border-color: #A1887F;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h1>Tus Productos Favoritos</h1>
        <div class="row">
            <asp:Repeater ID="repRepeater" runat="server">
                <ItemTemplate>
                    <div class="col">
                        <div class="card">
                            <img src="<%#Eval("ImagenUrl") %>" class="imgProducto mx-auto d-block" alt="Imagen del Producto">
                            <div class="card-body">
                                <h5 class="card-title"><%#Eval("Nombre") %></h5>
                                <p class="card-text">Código: <%#Eval("Codigo") %></p>
                                <p class="card-text"><%#Eval("Descripcion") %></p>
                                <p class="card-text">Marca: <%#Eval("Marca") %></p>
                                <p class="card-text">Categoría: <%#Eval("Categoria") %></p>
                                <p class="card-text">Precio: $<%#Eval("Precio", "{0:F2}") %></p>
                                <asp:Button ID="btnEliminarFav" CssClass="btn btn-primary" runat="server" Text="Eliminar de Favoritos ❌"
                                    CommandArgument='<%# Eval("Id") %>' OnClick="btnEliminarFav_Click" />

                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>



