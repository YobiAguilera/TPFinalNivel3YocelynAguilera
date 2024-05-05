<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="MiPerfil.aspx.cs" Inherits="catalogo_web.MiPerfil" %>

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
        .img-fluid {
            max-width: 100%;
            height: auto;
        }
    </style>
    <script>
        function validar() {
            let valido = true;
            const campos = [
                document.getElementById('tbxNombre'),
                document.getElementById('tbxApellido'),
                document.getElementById('tbxFechaNacimiento')
            ];
            campos.forEach(function (campo) {
                if (campo.value === "") {
                    campo.classList.add('is-invalid');
                    valido = false;
                } else {
                    campo.classList.remove('is-invalid');
                }
            });
            return valido;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Mi perfil</h2>
    <div class="row">
        <div class="col-md-6">
            <div class="mb-3">
                <label class="form-label">Email</label>
                <asp:TextBox ID="tbxEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Nombre</label>
                <asp:TextBox ID="tbxNombre" oninput="validar()" ClientIDMode="Static" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="El nombre es requerido" ControlToValidate="tbxNombre" runat="server" />
            </div>
            <div class="mb-3">
                <label class="form-label">Apellido</label>
                <asp:TextBox ID="tbxApellido" ClientIDMode="Static" oninput="validar()" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="El apellido es requerido" ControlToValidate="tbxApellido" runat="server" />
            </div>
            <div class="mb-3">
                <label class="form-label">Fecha de Nacimiento</label>
                <asp:TextBox ID="tbxFechaNacimiento" ClientIDMode="Static" oninput="validar()" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="La fecha de nacimiento es requerida" ControlToValidate="tbxFechaNacimiento" runat="server" />
            </div>
        </div>
        <div class="col-md-6">
            <div class="mb-3">
                <label class="form-label">Imagen de perfil</label>
                <input type="file" id="tbxImagen" runat="server" class="form-control" />
            </div>
            <asp:Image ID="imgNuevoPerfil" ImageUrl="https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg" runat="server" CssClass="img-fluid mb-3" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <asp:Button ID="btnGuardar" CssClass="btn btn-primary" OnClientClick="return validar()" runat="server" OnClick="btnGuardar_Click" Text="Guardar" />
            <a href="/" class="btn btn-link">Regresar</a>
        </div>
    </div>
</asp:Content>

