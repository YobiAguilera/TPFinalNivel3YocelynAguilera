<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="DetalleArticulos.aspx.cs" Inherits="catalogo_web.DetalleArticulos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <style>
        .detail-container {
            background-color: #f8f9fa;
            border-radius: 0.25rem;
            border: 1px solid #dee2e6;
            padding: 20px;
            box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
        }

        .detail-label {
            font-weight: bold;
            color: #495057;
        }

        .detail-value {
            color: #343a40;
        }

        .back-button {
            margin-top: 20px;
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
    <div class="container mt-4 detail-container">
        <h2>Detalle del Artículo</h2>
        <div class="row">
            <div class="col-md-6 text-center">
                <asp:Image ID="imgArticulo" runat="server" CssClass="img-fluid" />
            </div>
            <div class="col-md-6">
                <p>
                    <strong>Código:</strong>
                    <asp:Label ID="lblCodigo" runat="server" CssClass="detail-value"></asp:Label>
                </p>
                <p>
                    <strong>Nombre:</strong>
                    <asp:Label ID="lblNombre" runat="server" CssClass="detail-value"></asp:Label>
                </p>
                <p>
                    <strong>Descripción:</strong>
                    <asp:Label ID="lblDescripcion" runat="server" CssClass="detail-value"></asp:Label>
                </p>
                <p>
                    <strong>Marca:</strong>
                    <asp:Label ID="lblMarca" runat="server" CssClass="detail-value"></asp:Label>
                </p>
                <p>
                    <strong>Categoría:</strong>
                    <asp:Label ID="lblCategoria" runat="server" CssClass="detail-value"></asp:Label>
                </p>
                <p>
                    <strong>Precio:</strong>
                    <asp:Label ID="lblPrecio" runat="server" CssClass="detail-value"></asp:Label>
                </p>
                <asp:Button ID="btnAgregarFavoritos" runat="server" CssClass="btn btn-primary back-button" Text="❤️" OnClick="btnAgregarFavoritos_Click" />
                <asp:Button ID="btnVolver" runat="server" Text="Volver" CssClass="btn btn-primary back-button" PostBackUrl="~/Default.aspx" />
            </div>
        </div>
    </div>
</asp:Content>


