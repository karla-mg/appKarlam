<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaPrincipal.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaPrincipal"  debug=false%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous"/>
</head>
<body>
      <div class="container" style="font-family: 'Century Gothic'; ">
      <form id="form1" class="well form-horizontal" runat="server">
       
                   <legend><center><h2><b>Persona</b></h2></center></legend><br>



           

         <div class="form-group" style="font-family: 'Century Gothic'; " align="left">
         <asp:Label runat="server" Text="Nombre:" CssClass="control-label col-sm-2" for="nombre"></asp:Label>
         <asp:TextBox CssClass="form-control border border-secondary " ID="txtNombre"   runat="server" ViewStateMode="Disabled" Width="211px"></asp:TextBox>
         </div>
      
       <div class="form-group" style="font-family: 'Century Gothic'; " align="left">
       <asp:Label runat="server" Text="Sexo:" CssClass="control-label col-sm-2" for="sexo"></asp:Label>   
       <asp:DropDownList ID="ddlSexo" CssClass="form-control form-select border border-secondary " runat="server" Width="209px" >  </asp:DropDownList> 
</div>
       <br />
 <div  style="font-family: 'Century Gothic'; font-weight: bold">         
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;         
       <asp:Button ID="Button1" CssClass="btn btn-warning" runat="server" Text="Buscar" onclick="btnBuscar_Click" ViewStateMode="Disabled" Height="42px" Width="95px" />
       &nbsp;&nbsp;&nbsp;
       <asp:Button ID="Button2" CssClass="btn btn-success" runat="server" Text="Agregar" onclick="btnAgregar_Click" ViewStateMode="Disabled" Height="42px" Width="95px" />     
           </div>
         <br />
          <br />
       <div  style="font-family: 'Century Gothic'; " align="center">
        <asp:Label ID="lblDetalle" runat="server" Text="Detalle" CssClass="control-label " for="detail"  Font-Size="X-Large"></asp:Label>
        </div>
        <br />

       
       <div  class="table-responsive">
        
                <asp:GridView style="font-family: 'Century Gothic'" CssClass="table" ID="dgvPersonas" runat="server" 
                AllowPaging="True" AutoGenerateColumns="False" DataSourceID="DataSourcePersona" 
                Width="1100px" CellPadding="3" GridLines="Horizontal" 
                onrowcommand="dgvPersonas_RowCommand" BackColor="White" 
                  
                ViewStateMode="Disabled">
                <AlternatingRowStyle BackColor="#F7F7F7" />
                <Columns>
                    <asp:BoundField DataField="strClaveUnica" HeaderText="Clave Unica" ReadOnly="True" SortExpression="strClaveUnica" />
                    <asp:BoundField DataField="strNombre" HeaderText="Nombre" ReadOnly="True" SortExpression="strNombre" />
                    <asp:BoundField DataField="strAPaterno" HeaderText="Apellido Paterno" ReadOnly="True" SortExpression="strAPaterno" />
                    <asp:BoundField DataField="strAMaterno" HeaderText="Apellido Materno" ReadOnly="True" SortExpression="strAMaterno" />                
                    <asp:BoundField DataField="strCorreo" HeaderText="E-Mail" ReadOnly="True" SortExpression="strCorreo" />
                    <asp:BoundField DataField="strCodigoPostal" HeaderText="C.P." ReadOnly="True" SortExpression="strCodigoPostal" />
                   <%-- <asp:BoundField DataField="strRFC" HeaderText="RFC" ReadOnly="True" SortExpression="strRFC" />
                    <asp:BoundField DataField="dteFechaNac" HeaderText="Fecha Nacimiento" ReadOnly="True" SortExpression="dteFechaNac" />--%>     
                    <asp:BoundField DataField="CatSexo" HeaderText="Sexo" SortExpression="CatSexo" />
                 
                    <asp:TemplateField HeaderText="Editar">
                    <ItemTemplate>
                    <asp:ImageButton runat="server" ID="imgEditar" CommandName="Editar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/editrecord_16x16.png" />
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                    
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Eliminar" Visible="True">
                    <ItemTemplate>
                    <asp:ImageButton runat="server" ID="imgEliminar" CommandName="Eliminar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/delrecord_16x16.png" OnClientClick="javascript:return confirm('¿Está seguro de querer eliminar el registro seleccionado?', 'Mensaje de sistema')"/>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                    </asp:TemplateField>

                      <asp:TemplateField HeaderText="Direccion">
                      <ItemTemplate>
                      <asp:ImageButton runat="server" ID="imgDireccion" CommandName="Direccion" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/editrecord_16x16.png" />
                      </ItemTemplate>
                      <HeaderStyle HorizontalAlign="Center" />
                      <ItemStyle HorizontalAlign="Center" Width="50px" />         
                     </asp:TemplateField>
                </Columns>

                <FooterStyle BackColor="Gray" ForeColor="Gray" />
                <HeaderStyle BackColor="Gray" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="Gray" ForeColor="Gray" HorizontalAlign="Center" />
                <RowStyle BackColor="#CCCCCC" ForeColor="Black" />
                <SelectedRowStyle BackColor="#CCCCCC" Font-Bold="True" ForeColor="#F7F7F7" />
                <SortedAscendingCellStyle BackColor="#F4F4FD" />
                <SortedAscendingHeaderStyle BackColor="Gray" />
                <SortedDescendingCellStyle BackColor="Gray" />
                <SortedDescendingHeaderStyle BackColor="Gray" />
            </asp:GridView>     
        </div>

        <asp:LinqDataSource ID="DataSourcePersona" runat="server" 
        ContextTypeName="UTTT.Ejemplo.Linq.Data.Entity.DcGeneralDataContext" 
        onselecting="DataSourcePersona_Selecting" 
        Select="new (strNombre, strAPaterno, strAMaterno, CatSexo, strClaveUnica,id,strCorreo, strCodigoPostal)" 
        TableName="Persona" EntityTypeName="">
        </asp:LinqDataSource>

    </form>
    </div>
    </body>
    </html>
