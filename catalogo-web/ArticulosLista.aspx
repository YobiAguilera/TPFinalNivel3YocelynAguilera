<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ArticulosLista.aspx.cs" Inherits="catalogo_web.ArticulosLista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        window.onload = function () {
            var inputs = document.querySelectorAll('input[type=text]');
            for (var i = 0; i < inputs.length; i++) {
                inputs[i].addEventListener('keypress', function (e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();  
                   
                        // document.getElementById('<%= btnBuscar.ClientID %>').click();
                    }
                });
            }
        }

        function validarCampos() {
            var campo = document.getElementById('<%= ddlCampo.ClientID %>').value;
            var criterio = document.getElementById('<%= ddlCriterio.ClientID %>').value;
            var filtro = document.getElementById('<%= tbxFiltroAvanzado.ClientID %>').value;

            if (!campo || !criterio || filtro.trim() === "") {
                alert("Todos los campos deben estar rellenos para realizar la búsqueda.");
                return false;
            }
            return true;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="display-4 text-center mb-4">Busca tu artículo</h1>
    
    <div class="row">
        <div class="col-6">
            <div class="mb-3">
                <asp:Label ID="lblFiltro" runat="server" Text="Filtrar" CssClass="form-label"></asp:Label>
                <asp:TextBox runat="server" ID="tbxFiltro" CssClass="form-control" AutoPostBack="true" OnTextChanged="filtro_TextChanged" />
            </div>
        </div>
        <div class="col-6" style="display: flex; flex-direction: column; justify-content: flex-end;">
            <div class="mb-3">
                <asp:CheckBox ID="cbxAvanzado" runat="server" Text="Filtro Avanzado" AutoPostBack="true" OnCheckedChanged="cbxAvanzado_CheckedChanged" CssClass="form-check-input" />
            </div>
        </div>
    </div>
    
    <% if (FiltroAvanzado) { %>
    <div class="row">
        <div class="col-3">
            <div class="mb-3">
                <asp:Label ID="lblCampo" runat="server" Text="Campo" CssClass="form-label"></asp:Label>
                <asp:DropDownList ID="ddlCampo" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlCampo_SelectedIndexChanged">
                    <asp:ListItem Text="Nombre" />
                    <asp:ListItem Text="Código" />
                    <asp:ListItem Text="Marca" />
                    <asp:ListItem Text="Categoría" />
                    <asp:ListItem Text="Precio" />
                </asp:DropDownList>
            </div>
        </div>
        <div class="col-3">
            <div class="mb-3">
                <asp:Label ID="lblCriterio" runat="server" Text="Criterio" CssClass="form-label"></asp:Label>
                <asp:DropDownList ID="ddlCriterio" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
        </div>
        <div class="col-3">
            <div class="mb-3">
                <asp:Label ID="Label1" runat="server" Text="Filtro" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="tbxFiltroAvanzado" runat="server" CssClass="form-control" />
            </div>
        </div>
        <div class="col-3">
            <div class="mb-3">
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary" OnClientClick="return validarCampos();" OnClick="btnBuscar_Click" />
            </div>
        </div>
    </div>
    <% } %>

    <asp:GridView ID="dgvArticulos" runat="server" CssClass="table table-striped" DataKeyNames="Id" OnSelectedIndexChanged="dgvArticulos_SelectedIndexChanged" OnPageIndexChanging="dgvArticulos_PageIndexChanging" AllowPaging="true" PageSize="4" AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
            <asp:BoundField HeaderText="Código" DataField="Codigo" />
            <asp:BoundField HeaderText="Marca" DataField="Marca.Descripcion" />
            <asp:BoundField HeaderText="Categoría" DataField="Categoria.Descripcion" />
            <asp:BoundField HeaderText="Precio" DataField="Precio" />
            <asp:ImageField DataImageUrlField="ImagenUrl" ControlStyle-Height="100px" ControlStyle-Width="100px" HeaderText="Imagen" />
            <asp:CommandField HeaderText="Acción" ShowSelectButton="true" SelectText="📲" />
        </Columns>
    </asp:GridView>
    <a href="ArticuloFormulario.aspx" class="btn btn-primary">Agregar</a>

    <div style="height: 50px;"></div>
</asp:Content>
