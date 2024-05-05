<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="catalogo_web.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .validacion {
            color: red;
            font-size: 13px;
        }
        .form-label {
            font-weight: bold;
        }
        .btn-primary {
            background-color: #D7CCC8;
            border-color: #BCAAA4;
        }
        .btn-primary:hover {
            background-color: #BCAAA4;
            border-color: #A1887F;
        }
        a {
            color: #0056b3; 
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <h2 class="mb-3">Ingresa a tu perfil</h2>
                <div class="mb-3">
                    <label for="tbxEmail" class="form-label">Email</label>
                    <asp:TextBox runat="server" CssClass="form-control" REQUIRED ID="tbxEmail" />
                    <asp:RegularExpressionValidator ErrorMessage="Formato email, por favor." CssClass="validacion" ControlToValidate="tbxEmail" ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$" runat="server" />
                </div>
                <div class="mb-3">
                    <label for="tbxPassword" class="form-label">Contraseña</label>
                    <asp:TextBox ID="tbxPassword" runat="server" CssClass="form-control" TextMode="Password" />
                </div>
                <div class="mb-3">
                    <asp:Button ID="btnLogin" runat="server" Text="Ingresar" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                    <a href="/" class="btn btn-link">Cancelar</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

