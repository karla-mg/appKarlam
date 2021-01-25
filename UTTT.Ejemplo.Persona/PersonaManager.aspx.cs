#region Using

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Linq.Data.Entity;
using System.Data.Linq;
using System.Linq.Expressions;
using System.Collections;
using UTTT.Ejemplo.Persona.Control;
using UTTT.Ejemplo.Persona.Control.Ctrl;
using System.Text.RegularExpressions;
using System.IO;
using System.Diagnostics;
using System.Web.UI.MobileControls;

#endregion

namespace UTTT.Ejemplo.Persona
{
    public partial class PersonaManager : System.Web.UI.Page
    {
        #region Variables

        private SessionManager session = new SessionManager();
        private int idPersona = 0;
        private UTTT.Ejemplo.Linq.Data.Entity.Persona baseEntity;
        private DataContext dcGlobal = new DcGeneralkDataContext();
        private int tipoAccion = 0;

        #endregion

        #region Eventos

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.Response.Buffer = true;
                this.session = (SessionManager)this.Session["SessionManager"];
                this.idPersona = this.session.Parametros["idPersona"] != null ?
                    int.Parse(this.session.Parametros["idPersona"].ToString()) : 0;
                if (this.idPersona == 0)
                {
                    this.baseEntity = new Linq.Data.Entity.Persona();
                    this.tipoAccion = 1;
                }
                else
                {
                    this.baseEntity = dcGlobal.GetTable<Linq.Data.Entity.Persona>().First(c => c.id == this.idPersona);
                    this.tipoAccion = 2;
                }

                if (!this.IsPostBack)
                {
                    if (this.session.Parametros["baseEntity"] == null)
                    {
                        this.session.Parametros.Add("baseEntity", this.baseEntity);
                    }
                    List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().ToList();
                    CatSexo catTemp = new CatSexo();
                    catTemp.id = -1;
                    catTemp.strValor = "Seleccionar";
                    
                    lista.Insert(0, catTemp);
                    this.ddlSexo.DataTextField = "strValor";
                    this.ddlSexo.DataValueField = "id";
                    this.ddlSexo.DataSource = lista;
                    this.ddlSexo.DataBind();

                    this.ddlSexo.SelectedIndexChanged += new EventHandler(ddlSexo_SelectedIndexChanged);
                    this.ddlSexo.AutoPostBack = true;
                    if (this.idPersona == 0)
                    {
                        this.lblAccion.Text = "Agregar";
                      
                        DateTime tiempo = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
                        this.dteCalendario.TodaysDate = tiempo;
                        this.dteCalendario.SelectedDate = tiempo;
                    }
                    else
                    {
                        this.lblAccion.Text = "Editar";
                        this.txtNombre.Text = this.baseEntity.strNombre;
                        this.txtAPaterno.Text = this.baseEntity.strAPaterno;
                        this.txtAMaterno.Text = this.baseEntity.strAMaterno;
                        this.txtClaveUnica.Text = this.baseEntity.strClaveUnica;

                        DateTime? fechaNacimiento = this.baseEntity.dteFechaNac;
                        if (fechaNacimiento != null)
                        {
                            this.dteCalendario.TodaysDate = (DateTime)fechaNacimiento;
                            this.dteCalendario.SelectedDate = (DateTime)fechaNacimiento;
                        }
                        this.txtCorreo.Text = this.baseEntity.strCorreo;
                        this.txtCP.Text = this.baseEntity.strCodigoPostal;
                        this.txtRFC.Text = this.baseEntity.strRFC;
                        this.setItem(ref this.ddlSexo, baseEntity.CatSexo.strValor);
                    }                
                }

            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al cargar la página");
                this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            }

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
           
            
            try
            {
                
                    DateTime fecNac = this.dteCalendario.SelectedDate.Date;
                    DateTime fechaHoy = DateTime.Today;
                    int edad = fechaHoy.Year - fecNac.Year;
                    if (fechaHoy < fecNac.AddYears(edad)) edad--;


                    if (edad < 18)
                    {
                        this.showMessage("Tú edad no está permitida para registrarte!!");
                    }


                if (!Page.IsValid)
                {
                    return;

                }

                DataContext dcGuardar = new DcGeneralkDataContext();
                UTTT.Ejemplo.Linq.Data.Entity.Persona persona = new Linq.Data.Entity.Persona();
                if (this.idPersona == 0)
                {
                   

                    persona.strClaveUnica = this.txtClaveUnica.Text.Trim();
                    persona.strNombre = this.txtNombre.Text.Trim();
                    persona.strAMaterno = this.txtAMaterno.Text.Trim();
                    persona.strAPaterno = this.txtAPaterno.Text.Trim();
                    persona.idCatSexo = int.Parse(this.ddlSexo.Text);

                    persona.strCorreo = this.txtCorreo.Text.Trim();
                    persona.strCodigoPostal = this.txtCP.Text.Trim();
                    persona.strRFC = this.txtRFC.Text.Trim();

                    DateTime fechaNacimiento = this.dteCalendario.SelectedDate.Date;
                    persona.dteFechaNac = fechaNacimiento;


                    //persona.strClaveUnica = !this.txtClaveUnica.Text.Equals(String.Empty) ?
                    //  this.txtClaveUnica.Text : "Null";
                    String mensaje = String.Empty;

                    if(!this.validacion(persona, ref mensaje))
                    {
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }
                    if (!this.validacionSQL(ref mensaje))
                    {
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }
                    if (!this.validacionHTML(ref mensaje))
                    {
                        this.lblMensaje.Text = mensaje;
                        this.lblMensaje.Visible = true;
                        return;
                    }

               

                    dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().InsertOnSubmit(persona);
                    dcGuardar.SubmitChanges();
                    this.showMessage("El registro se agrego correctamente.");
                    this.Response.Redirect("~/PersonaPrincipal.aspx", false);
                    
                }
                if (this.idPersona > 0)
                {
                    persona = dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().First(c => c.id == idPersona);
                    persona.strClaveUnica = this.txtClaveUnica.Text.Trim();
                    persona.strNombre = this.txtNombre.Text.Trim();
                    persona.strAMaterno = this.txtAMaterno.Text.Trim();
                    persona.strAPaterno = this.txtAPaterno.Text.Trim();
                    persona.idCatSexo = int.Parse(this.ddlSexo.Text);
                    persona.strCorreo = this.txtCorreo.Text.Trim();
                    persona.strCodigoPostal = this.txtCP.Text.Trim();
                    persona.strRFC = this.txtRFC.Text.Trim();

                    dcGuardar.SubmitChanges();
                    this.showMessage("El registro se edito correctamente.");
                    this.Response.Redirect("~/PersonaPrincipal.aspx", false);
                }
            }
            catch (Exception _e)
            {
                this.showMessageException(_e.Message);
           
            }
            
        }
      


        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            try
            {              
                this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }

        }

        protected void ddlSexo_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int idSexo = int.Parse(this.ddlSexo.Text);
                Expression<Func<CatSexo, bool>> predicateSexo = c => c.id == idSexo;
                predicateSexo.Compile();
                List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().Where(predicateSexo).ToList();
                CatSexo catTemp = new CatSexo();            
                this.ddlSexo.DataTextField = "strValor";
                this.ddlSexo.DataValueField = "id";
                this.ddlSexo.DataSource = lista;
                this.ddlSexo.DataBind();
            }
            catch (Exception)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        #endregion

        #region Metodos

        public void setItem(ref DropDownList _control, String _value)
        {
            foreach (ListItem item in _control.Items)
            {
                if (item.Value == _value)
                {
                    item.Selected = true;
                    break;
                }
            }
            _control.Items.FindByText(_value).Selected = true;
        }

        public bool validacion(UTTT.Ejemplo.Linq.Data.Entity.Persona _persona, ref String _mensaje)
        {
            if (_persona.idCatSexo==-1)
            {
                _mensaje = "Seleccione Campo 'Sexo' ";
                return false;
            }
            int i = 0;
            if (int.TryParse(_persona.strClaveUnica,out i)== false)
            {
                _mensaje = "La clave no es un numero";
                return false;
            }
            if (int.Parse(_persona.strClaveUnica)<100 || int.Parse(_persona.strClaveUnica) > 1000)
            {
                _mensaje = "La clave esta fuera del rango";
                return false;
            }
            if (_persona.strClaveUnica.Length < 3)
            {
                _mensaje = " Los caracteres del Clave Unica, son 3 establecidos";
                return false;
            }
            if (_persona.strNombre.Length>50)
            {
                _mensaje = " Los caracteres del Nombre, rebasan los 50 establecidos";
                return false;
            }
            if (_persona.strNombre.Equals(String.Empty))
            {
                _mensaje = "Nombre esta vacío";
                return false;
            }
            bool resultado = Regex.IsMatch(_persona.strNombre, @"^[a-zA-Z]+$");
            if (!resultado)
            {
                _mensaje = " Los caracteres del Nombre deben ser letras";
                return false;
            }


            if (_persona.strAPaterno.Length > 50)
            {
                _mensaje = " Los caracteres de A.Paterno, rebasan los 50 establecidos";
                return false;
            }
            if (_persona.strAPaterno.Equals(String.Empty))
            {
                _mensaje = "A.Paterno esta vacío";
                return false;
            }
            bool resultadoap = Regex.IsMatch(_persona.strAPaterno, @"^[a-zA-Z]+$");
            if (!resultadoap)
            {
                _mensaje = " Los caracteres del A.Paterno deben ser letras";
                return false;
            }

            if (_persona.strAMaterno.Length > 50)
            {
                _mensaje = " Los caracteres de A.Materno, rebasan los 50 establecidos";
                return false;
            }
            if (_persona.strAMaterno.Equals(String.Empty))
            {
                _mensaje = "A.Materno esta vacío";
                return false;
            }
            bool resultadoaM = Regex.IsMatch(_persona.strAMaterno, @"^[a-zA-Z]+$");
            if (!resultadoaM)
            {
                _mensaje = " Los caracteres del A.Materno deben ser letras";
                return false;
            }

            if (_persona.strCorreo.Length > 50)
            {
                _mensaje = " Los caracteres de Correo, rebasan los 50 establecidos";
                return false;
            }
            if (_persona.strCorreo.Equals(String.Empty))
            {
                _mensaje = "E-Mail esta vacío";
                return false;
            }
            //bool resultadoc = Regex.IsMatch(_persona.strAPaterno, @"^[\w!#$%&'*+\-/=?\^_`{|}~]+(\.[\w!#$%&'*+\-/=?\^_`{|}~]+)*@((([\-\w]+\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\.){3}[0-9]{1,3}))\z");
            //if (!resultadoc)
            //{
            //    _mensaje = " Los caracteres del E-Mail no son correctos";
            //    return false;
            //}

            if (_persona.strCodigoPostal.Length > 5)
            {
                _mensaje = " Los caracteres de C.P., rebasan los 5 establecidos";
                return false;
            }
            if (_persona.strCodigoPostal.Equals(String.Empty))
            {
                _mensaje = "Codigo Postal esta vacío";
                return false;
            }
            int ic = 0;
            if (int.TryParse(_persona.strCodigoPostal, out ic) == false)
            {
                _mensaje = "El codigo Postal no es un numero";
                return false;
            }

            if (_persona.strRFC.Equals(String.Empty))
            {
                _mensaje = "RFC esta vacío";
                return false;
            }
            if (_persona.strRFC.Length > 13)
            {
                _mensaje = " Los caracteres del EFC., rebasan los 13 establecidos";
                return false;
            }
            //bool resultadorf = Regex.IsMatch(_persona.strAPaterno, @"'^([A-ZÑ\x26]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])([A-Z]|[0-9]){2}([A]|[0-9]){1})?$'");
            //if (!resultadorf)
            //{
            //    _mensaje = " Los caracteres del RFC no son correctos";
            //    return false;
            //}



            return true;
        }
        public bool validacionSQL(ref String _mensaje)
        {
            CtrlValidaInyeccion valida = new CtrlValidaInyeccion();
            string mensajefuncion = string.Empty;
            if (valida.sqlInyectionValida(this.txtClaveUnica.Text.Trim(), ref mensajefuncion, "Clave Unica", ref this.txtClaveUnica))
            {
                _mensaje = mensajefuncion;
                return false;
            }

            if (valida.sqlInyectionValida(this.txtNombre.Text.Trim(), ref mensajefuncion, "Nombre", ref this.txtNombre))
            {
                _mensaje = mensajefuncion;
                return false;
            }

            if (valida.sqlInyectionValida(this.txtAPaterno.Text.Trim(), ref mensajefuncion, "A. Paterno", ref this.txtAPaterno))
            {
                _mensaje = mensajefuncion;
                return false;
            }
            if (valida.sqlInyectionValida(this.txtCorreo.Text.Trim(), ref mensajefuncion, "Correo", ref this.txtCorreo))
            {
                _mensaje = mensajefuncion;
                return false;
            }
            if (valida.sqlInyectionValida(this.txtCP.Text.Trim(), ref mensajefuncion, "Código Postal", ref this.txtCP))
            {
                _mensaje = mensajefuncion;
                return false;
            }
            if (valida.sqlInyectionValida(this.txtRFC.Text.Trim(), ref mensajefuncion, "RFC", ref this.txtRFC))
            {
                _mensaje = mensajefuncion;
                return false;
            }

            return true;
        }
        
        public bool validacionHTML (ref String _mensaje)
        {
            CtrlValidaInyeccion valida = new CtrlValidaInyeccion();
            string mensajefuncion = string.Empty;
            if (valida.htmlInyectionValida(this.txtClaveUnica.Text.Trim(), ref mensajefuncion, "Clave Unica", ref this.txtClaveUnica))
            {
                _mensaje = mensajefuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtNombre.Text.Trim(), ref mensajefuncion, "Nombre", ref this.txtNombre))
            {
                _mensaje = mensajefuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtAPaterno.Text.Trim(), ref mensajefuncion, "A. Paterno", ref this.txtAPaterno))
            {
                _mensaje = mensajefuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtAMaterno.Text.Trim(), ref mensajefuncion, "A. Materno", ref this.txtAMaterno))
            {
                _mensaje = mensajefuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtCorreo.Text.Trim(), ref mensajefuncion, "E-Mail", ref this.txtCorreo))
            {
                _mensaje = mensajefuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtCP.Text.Trim(), ref mensajefuncion, "Código Postal", ref this.txtCP))
            {
                _mensaje = mensajefuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtRFC.Text.Trim(), ref mensajefuncion, "RFC", ref this.txtRFC))
            {
                _mensaje = mensajefuncion;
                return false;
            }
            return true;
        }
        #endregion

        protected void dteCalendario_SelectionChanged(object sender, EventArgs e)
        {
           
        }
    }
   
       
    
}