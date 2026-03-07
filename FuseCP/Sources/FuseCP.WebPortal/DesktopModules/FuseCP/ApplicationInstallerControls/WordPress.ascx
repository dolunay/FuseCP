<%@ Control Language="c#" AutoEventWireup="true" %>
<%@ Implements interface="FuseCP.Portal.IWebInstallerSettings" %>
<%@ Import namespace="FuseCP.EnterpriseServer" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.Security.Cryptography" %>

<script language="C#" runat="server">
		void Page_Load()
		{
		}
		
		public void GetSettings(InstallationInfo inst)
		{
			inst["weblog.title"] = txtWebLogTitle.Text.Replace("'", "''");
            inst["admin.password"] = MD5(txtPassword.Text);
			inst["admin.email"] = txtEmail.Text;
		}

    public static string MD5(string str)
    {
        System.Text.UTF8Encoding enc = new System.Text.UTF8Encoding();
        System.Security.Cryptography.MD5CryptoServiceProvider md5 = new System.Security.Cryptography.MD5CryptoServiceProvider();
        byte[] hashedBytes = md5.ComputeHash(enc.GetBytes(str));

        string hashedString = "";

        for (int i = 0; i < hashedBytes.Length; i++)
            hashedString += Convert.ToString(hashedBytes[i], 16).PadLeft(2, '0');

        return hashedString.PadLeft(32, '0').ToLower();
    }
    
</script>
<table class="table table-borderless align-middle mb-0" >
	<tr>
		<td class="SubHead">WebLog Title:</td>
		<td class="Normal">
			<asp:textbox id="txtWebLogTitle" runat="server" CssClass=form-control Text="My WebLog"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead text-nowrap" >Username:</td>
		<td class="Normal" >
			<b>admin</b>
		</td>
	</tr>
	<tr>
		<td class="SubHead">Administrator Password:</td>
		<td class="Normal">
			<asp:textbox id="txtPassword" runat="server" TextMode="Password" CssClass=form-control></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead">Confirm Password:</td>
		<td class="Normal">
			<asp:textbox id="txtConfirmPassword" runat="server" TextMode="Password" CssClass=form-control></asp:textbox>
			<asp:comparevalidator EnableClientScript=True Enabled=True id="ComparePassword" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" Cssclass="color:red">*</asp:comparevalidator>
		</td>
	</tr>
	<tr>
		<td class="SubHead text-nowrap" >Administrator E-Mail:</td>
		<td class="Normal" >
			<asp:textbox id="txtEmail" runat="server" CssClass=form-control>admin@admin.com</asp:textbox>
		</td>
	</tr>
</table>
