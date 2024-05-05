<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="catalogo_web.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet">
    <style>
        .card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            border-radius: 0.5rem;
            background-color: #f5f5f5; 
            border: none;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
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
    <h1 class="display-4 text-center mb-4">¡Bienvenidos a Yobi Store!</h1>
    <p class="lead text-center">Descubre lo mejor en tecnología. ¿Listo para hacer tus compras?</p>

    <div class="row row-cols-1 row-cols-md-3 g-4">
        <asp:Repeater ID="repRepetidor" runat="server">
            <ItemTemplate>
                <div class="col" id='<%# "articulo-" + Eval("Id") %>'>
                    <div class="card h-100">
                        <img src="<%# Eval("ImagenUrl") %>" class="card-img-top" alt="Imagen de <%# Eval("Nombre") %>">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title"><%# Eval("Nombre") %></h5>
                            <p class="card-text"><%# Eval("Descripcion") %></p>
                            <a href='DetalleArticulos.aspx?id=<%# Eval("Id") %>' class="btn btn-primary mt-auto">
                                Ver detalle <i class="fas fa-angle-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div style="height: 50px;"></div>
</asp:Content>


