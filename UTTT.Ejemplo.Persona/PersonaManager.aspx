<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaManager.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaManager" Debug="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <script src="Scripts/validaciones.js " type="text/javascript"></script>
    <script type="text/javascript">
        function validarFormatoFecha(campo) {
            var RegExPattern = /^\d{1,2}\/\d{1,2}\/\d{2,4}$/;
            if ((campo.match(RegExPattern)) && (campo != '')) {
                return true;
            } else {
                return false;
            }
        }


    </script>

    <script type="text/javascript">

        function soloLetras(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return true;
            return false;
        }
    </script>
    <script type="text/javascript">
        function justNumbers(e) {
            var keynum = window.event ? window.event.keyCode : e.which;
            if ((keynum == 8 || keynum == 48))
                return true;
            if (keynum <= 47 || keynum >= 58) return false;
            return /\d/.test(String.fromCharCode(keynum));

        }
    </script>
    <script type="text/javascript">
        window.onload = function () {
            var pos = window.name || 0;
            window.scrollTo(0, pos);
        }
        window.onunload = function () {
            window.name = self.pageYOffset || (document.documentElement.location.assign() + document.location.assign());
        }
    </script>
    <title></title>
    <%--<link href="StyleSheet1.css" rel="stylesheet" />--%>
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous"/>
</head>
<body>
    <div class="container" style="font-family: 'Century Gothic'; ">
     
    <form id="form1" runat="server" class="well form-horizontal"  onsubmit="return camposValid()">
     <fieldset>

        
           <legend><center><h2><b>Persona</b></h2></center></legend><br>
       
        
        <div  style="font-family: 'Century Gothic'; " align="center">
        <asp:Label ID="lblAccion" runat="server" Text="Accion" CssClass="control-label " for="accion"  Font-Size="X-Large"></asp:Label>
        </div>
        <br />

        <div class="form-group"  style="font-family: 'Century Gothic'; "   >
        <asp:Label runat="server" Text="Sexo:" Class="control-label col-sm-4" for="sexo"></asp:Label>
        <div class="col-md-4 inputGroupContainer">
         <div class="input-group">
         <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
        <asp:DropDownList ID="ddlSexo" runat="server" Class="form-control border border-secondary"  OnSelectedIndexChanged="ddlSexo_SelectedIndexChanged" >
        </asp:DropDownList>
             </div>
        <asp:RequiredFieldValidator  ID="rfvSexo" runat="server" ControlToValidate="ddlSexo" EnableClientScript="False" ErrorMessage="Selecciona un valor*" InitialValue="-1"></asp:RequiredFieldValidator>       
            
            </div>
            </div>
        

       

        <div class="form-group"  style ="font-family: 'Century Gothic'; ">
        <asp:Label runat="server" Text="Clave Única:" CssClass="control-label col-sm-4 " for="txtClaveUnica"></asp:Label> 
            <div class="col-md-4 inputGroupContainer">
         <div class="input-group">
             <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
        <asp:TextBox Class="form-control border border-secondary "  ID="txtClaveUnica" onkeypress="return justNumbers(event);" runat="server" ViewStateMode="Disabled" minlength="3" MaxLength="3"   ></asp:TextBox>
             </div>
        <asp:RequiredFieldValidator ID="rfvClave" runat="server" ControlToValidate="txtClaveUnica" EnableClientScript="False" ErrorMessage="Clave Obligatoria*"></asp:RequiredFieldValidator>
        </div>
           </div>
           <div class="form-group" style="font-family: 'Century Gothic'; " >
           <asp:Label  runat="server" Text="Nombre:" CssClass="control-label col-sm-4" for="nombre"></asp:Label>
                 <div class="col-md-4 inputGroupContainer">
         <div class="input-group">
             <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
           <asp:TextBox Class="form-control border border-secondary  " ID="txtNombre" minlength="4" MaxLength="50" onkeypress="return soloLetras(event);" runat="server"  ViewStateMode="Disabled"   ></asp:TextBox>
             </div>
           <asp:RequiredFieldValidator  ID="rfvNombre" runat="server" ControlToValidate="txtNombre" EnableClientScript="False" ErrorMessage="Nombre Obligatorio*"></asp:RequiredFieldValidator>         
           </div>
         </div>

          
          <div class="form-group"  style="font-family: 'Century Gothic'; " >
          <asp:Label runat="server" Text="Apellido Paterno:" CssClass="control-label col-sm-4" for="APaterno"></asp:Label>
                <div class="col-md-4 inputGroupContainer">
         <div class="input-group">
             <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
          <asp:TextBox Class="form-control border border-secondary " ID="txtAPaterno" minlength="3" MaxLength="50" onkeypress="return soloLetras(event);" runat="server" ViewStateMode="Disabled" ></asp:TextBox>
             </div>
          <asp:RequiredFieldValidator ID="rfvAPaterno" runat="server" ControlToValidate="txtAPaterno" EnableClientScript="False" ErrorMessage="Apellido Paterno Obligatorio*"></asp:RequiredFieldValidator>        
          </div>
        </div>
        
           <div class="form-group" style="font-family: 'Century Gothic'; " align="left">
           <asp:Label runat="server" Text="Apellido Materno:" CssClass="control-label col-sm-4" for="AMaterno"></asp:Label>
                <div class="col-md-4 inputGroupContainer">
         <div class="input-group">
             <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
           <asp:TextBox Class="form-control border border-secondary " ID="txtAMaterno" minlength="3" MaxLength="50" onkeypress="return soloLetras(event);" runat="server" ViewStateMode="Disabled"  ></asp:TextBox>
             </div>
           <asp:RequiredFieldValidator ID="rfvAMaterno" runat="server" ControlToValidate="txtAMaterno" EnableClientScript="False" ErrorMessage="Apellido  Materno Obligatorio*"></asp:RequiredFieldValidator>
            </div>
               </div>
           

        <div class="form-group"  style="font-family: 'Century Gothic'; " align="left">        
          <asp:Label runat="server" Text="Fecha de Nacimiento:" CssClass="control-label col-sm-4"  for="FechaNac"></asp:Label>
              <div class="col-md-4 inputGroupContainer">
         <div class="input-group"> 
             <span class="input-group-addon" ><i > <asp:ImageButton ID="btnCa"   runat="server" Height="20px"  Width="20px" ImageUrl="~/Images/calendar.png" ></asp:ImageButton></i></span>

          <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
          <asp:TextBox ID="TextBox1" runat="server" onkeypress="return justNumbers(event);" CssClass="form-control border border-secondary"></asp:TextBox>
             
              </div>
             <asp:RequiredFieldValidator ID="rfvFechaNaci" runat="server" ControlToValidate="TextBox1" ErrorMessage="Fecha de Nacimiento Obligatoria*"></asp:RequiredFieldValidator>
             <%--<asp:RegularExpressionValidator ID="revFecha" runat="server" ControlToValidate="TextBox1" ErrorMessage="Fecha Inválida*" ValidationExpression="^([0-2][0-9]|3[0-1])(\/|-)(0[1-9]|1[0-2])\2(\d{4})(\s)([0-1][0-9]|2[0-3])(:)([0-5][0-9])$"></asp:RegularExpressionValidator>--%>
             
          <ajaxToolkit:CalendarExtender   ID="Calendar1" runat="server" Format="dd-MM-yyyy" PopupPosition="BottomRight"  BehaviorID="Calendar1" PopupButtonID="btnCa" TargetControlID="TextBox1" ></ajaxToolkit:CalendarExtender>
            </div>

          </div>



            <div class="form-group" style="font-family: 'Century Gothic'; " align="left" >
            <asp:Label runat="server" Text="Email:" CssClass="control-label col-sm-4" for="email"></asp:Label>
                <div class="col-md-4 inputGroupContainer">
         <div class="input-group">
             <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
            <asp:TextBox CssClass="form-control border border-secondary" ID="txtCorreo" runat="server" MaxLength="50" TextMode="Email" ></asp:TextBox>
             </div>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtCorreo" EnableClientScript="False" ErrorMessage="Correo Inválido!*" ValidationExpression="^[a-zA-Z0-9.!#$%&amp;'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$"></asp:RegularExpressionValidator>
            <asp:RequiredFieldValidator ID="rfvCorreo" runat="server" ControlToValidate="txtCorreo" EnableClientScript="False" ErrorMessage="E-Mail Obligatorio*"></asp:RequiredFieldValidator>
            </div>
        </div>
  
            <div class="form-group"  style="font-family: 'Century Gothic'; " align="left">
            <asp:Label runat="server" Text="Código Postal:" CssClass="control-label col-sm-4" for="cp"></asp:Label>
                   <div class="col-md-4 inputGroupContainer">
         <div class="input-group">
             <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
            <asp:TextBox CssClass="form-control border border-secondary " ID="txtCP" onkeypress="return justNumbers(event);" runat="server" MaxLength="5" minlength="5" ></asp:TextBox>
             </div>
            <asp:RequiredFieldValidator ID="rfvCP" onkeypress="return justNumbers(event);" runat="server" ControlToValidate="txtCP" EnableClientScript="False" ErrorMessage="Código Postal Obligatorio*"></asp:RequiredFieldValidator>                
            </div>
                </div>
           

             <div class="form-group"  style="font-family: 'Century Gothic'; " align="left">
             <asp:Label runat="server" Text="RFC:" CssClass="control-label col-sm-4" for="rfc"></asp:Label>       
                    <div class="col-md-4 inputGroupContainer">
         <div class="input-group">
             <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
             <asp:TextBox CssClass="form-control border border-secondary " ID="txtRFC" runat="server"  ></asp:TextBox>
             </div>
             <asp:RequiredFieldValidator ID="rfvRFC"  runat="server" ControlToValidate="txtRFC" EnableClientScript="False" ErrorMessage="RFC  Obligatorio*"></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ID="revRFCi" runat="server" ControlToValidate="txtRFC" ErrorMessage="RFC inválido!" ValidationExpression="(([A-Z]|\s){1})(([A-Z]){3})([0-9]{6})((([A-Z]|[0-9]){3}))" EnableClientScript="False"></asp:RegularExpressionValidator>
             </div>
                 </div>

                     <div class="form-group"  style="font-family: 'Century Gothic'; " align="left">
                   <asp:Label runat="server" Text="Estado Civil:" CssClass="control-label col-sm-4" for="edoCivil"></asp:Label>       
                   <div class="col-md-4 inputGroupContainer">
                    <div class="input-group">
             <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
             <asp:DropDownList ID="ddlEstadoCivil" runat="server" Class="form-control border border-secondary"  OnSelectedIndexChanged="ddlEstadoCivil_SelectedIndexChanged" >
        </asp:DropDownList>
             </div>
          <asp:RequiredFieldValidator ID="rvEstadoCivil"  runat="server" ControlToValidate="edoCivil" EnableClientScript="False" ErrorMessage="Estado Civil Obligatorio*"></asp:RequiredFieldValidator>

                    </div>
                     </div>



    

        <div class="form-group" style="font-family: 'Century Gothic';  ">
         <div  style="font-family: 'Century Gothic'; font-weight: bold" align="center">     
         <asp:Label Visible="false" CssClass="alert alert-danger" ID="lblMensaje" runat="server"  
             Font-Size="Large" ForeColor="Red"     Width="500px"></asp:Label>
         </div>
        </div> 
           <%--<asp:TextBox CssClass="form-control border border-secondary "   runat="server" Width="500px"></asp:TextBox>--%>          <%--<div align="center">  --%>          <%--<asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged">
          </asp:Calendar>--%>          <%--</div>--%>    
      
      
          <div  style="font-family: 'Century Gothic'; font-weight: bold" align="right">     
          <div class="col-sm-10">
          <asp:Button CssClass="btn btn-success" ID="btnAceptar" runat="server" Text="Guardar"
              OnClick="btnAceptar_Click" ViewStateMode="Disabled"   Height="46px" Width="123px" >          </asp:Button>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button CssClass="btn btn-warning" ID="btnCancelar" runat="server" Text="Cancelar" OnClick="btnCancelar_Click" ViewStateMode="Disabled"   Height="46px" Width="123px"/>
               <br />
           <br />
          </div>
          </div>
        
        
              </fieldset>
       
    </form>
         
         </div>
</body>
</html>
