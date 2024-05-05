<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ArticuloFormulario.aspx.cs" Inherits="catalogo_web.ArticuloFormulario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .validacion {
            color: red;
            font-size: 13px;
        }
        .form-label {
            font-weight: bold;
        }
        .btn-primary, .btn-danger, .btn-outline-danger {
            border-radius: 0.25rem; 
        }
        .btn-primary {
            background-color: #D7CCC8; 
            border-color: #BCAAA4;
        }
        .btn-primary:hover {
            background-color: #BCAAA4;
            border-color: #A1887F;
        }
        .btn-danger {
            background-color: #e57373; 
            border-color: #e57373;
        }
        .btn-danger:hover {
            background-color: #ef5350;
            border-color: #d32f2f;
        }
        .btn-outline-danger {
            color: #e57373;
            border-color: #e57373;
        }
        .btn-outline-danger:hover {
            background-color: #e57373;
            color: white;
        }
        a {
            text-decoration: none; 
            color: #0056b3; 
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function validarFormulario() {
            let valido = true;

            const campos = [
                document.getElementById('<%= tbxCodigo.ClientID %>'),
                document.getElementById('<%= tbxNombre.ClientID %>'),
                document.getElementById('<%= tbxDescripcion.ClientID %>'),
                document.getElementById('<%= tbxPrecio.ClientID %>')
            ];

            campos.forEach(function (campo) {
                if (campo.value === "" || (campo.tagName === "SELECT" && campo.selectedIndex === 0)) {
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
    <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
    <h1>Nuevo artículo</h1>
    <div class="row">
        <div class="col-6">
            <div class="mb-3">
                <label for="tbxId" class="form-label">Id</label>
                <asp:TextBox runat="server" ID="tbxId" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label for="tbxCodigo" class="form-label">Código</label>
                <asp:TextBox runat="server" ID="tbxCodigo" ClientIDMode="Static" CssClass="form-control" oninput="validarFormulario(this)" />
                <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="El código es requerido" ControlToValidate="tbxCodigo" runat="server" />
            </div>
            <div class="mb-3">
                <label for="tbxNombre" class="form-label">Nombre</label>
                <asp:TextBox runat="server" ID="tbxNombre" ClientIDMode="Static" CssClass="form-control" oninput="validarFormulario(this)" />
                <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="El nombre es requerido" ControlToValidate="tbxNombre" runat="server" />
            </div>
            <div class="mb-3">
                <label for="ddlMarca" class="form-label">Marca</label>
                <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="mb-3">
                <label for="ddlCategoria" class="form-label">Categoría</label>
                <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select"></asp:DropDownList>
            </div>
            <div class="mb-3">
                <label for="tbxPrecio" class="form-label">Precio</label>
                <asp:TextBox runat="server" ID="tbxPrecio" ClientIDMode="Static" CssClass="form-control" oninput="validarFormulario(this)" />
                <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="Defina el precio" ControlToValidate="tbxPrecio" runat="server" />
                <asp:RegularExpressionValidator ErrorMessage="Solo números." ControlToValidate="tbxPrecio" ValidationExpression="^[0-9.,]+$" runat="server" />
            </div>
            <div class="mb-3">
                <asp:Button ID="btnAceptar" runat="server" CssClass="btn btn-primary" Text="Aceptar" OnClick="btnAceptar_Click" OnClientClick="return validarFormulario();" />
                <a href="ArticulosLista.aspx" class="btn btn-link">Cancelar</a>
            </div>
        </div>

        <div class="col-6">
            <div class="mb-3">
                <label for="tbxDescripcion" class="form-label">Descripción:</label>
                <asp:TextBox runat="server" ClientIDMode="Static" ID="tbxDescripcion" TextMode="MultiLine" CssClass="form-control" oninput="validarFormulario(this)" />
                <asp:RequiredFieldValidator CssClass="validacion" ErrorMessage="Agregue la descripción del producto" ControlToValidate="tbxDescripcion" runat="server" />
            </div>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="mb-3">
                        <label for="tbxImagenUrl" class="form-label">Url Imagen</label>
                        <asp:TextBox runat="server" ID="tbxImagenUrl" CssClass="form-control" AutoPostBack="true" OnTextChanged="tbxImagenUrl_TextChanged" />
                    </div>
                    <asp:Image ID="imgArticulo" ImageUrl="https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/800px-No-Image-Placeholder.svg.png" runat="server" Width="55%" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <div class="row">
        <div class="col-6">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="mb-3">
                        <asp:Button ID="btnEliminar" runat="server" OnClick="btnEliminar_Click" CssClass="btn btn-danger" Text="Eliminar" />
                    </div>
                    <%if (ConfirmarEliminacion)
                        {  %>
                    <div class="mb-3">
                        <asp:CheckBox Text="Confirmar eliminación" ID="cbxConfirmarEliminacion" runat="server" />
                        <asp:Button ID="btnConfirmarEliminacion" runat="server" CssClass="btn btn-outline-danger" OnClick="btnConfirmarEliminacion_Click" Text="Eliminar" />
                    </div>
                    <%} %>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>

