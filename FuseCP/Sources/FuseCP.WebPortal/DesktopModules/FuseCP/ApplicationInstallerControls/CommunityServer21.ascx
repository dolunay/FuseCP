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
			inst["ValidationKey"] = CreateCryptoKey(20);
			inst["DecryptionKey"] = CreateCryptoKey(24);
				
			inst["admin.username"] = txtUsername.Text;
			inst["admin.password"] = txtPassword.Text;
			inst["admin.email"] = txtEmail.Text;
			inst["createSamples"] = chkCreateSample.Checked ? "1" : "0";
		}
		
		protected string CreateCryptoKey(int len)
		{
			byte[] bytes = new byte[len];
			new RNGCryptoServiceProvider().GetBytes(bytes);
	        
			StringBuilder sb = new StringBuilder();
			for(int i = 0; i < bytes.Length; i++)
			{	
				sb.Append(string.Format("{0:X2}",bytes[i]));
			}
			
			return sb.ToString();
		}
</script>
<table class="table table-borderless align-middle mb-0">
	<tr>
		<td class=SubHead colspan=2>
			Enter the username and password you would like to use for the administrator account
			of your new Community Server site:
		</td>
	</tr>
	<tr>
		<td class="SubHead text-nowrap" >Username:</td>
		<td class="Normal">
			<asp:textbox id="txtUsername" runat="server" CssClass=form-control>admin</asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead">Password:</td>
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
		<td class="SubHead text-nowrap" >E-Mail:</td>
		<td class="Normal">
			<asp:textbox id="txtEmail" runat="server" CssClass=form-control>admin@site.com</asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead">&nbsp;</td>
		<td class="NormalBold">
			<asp:Checkbox id="chkCreateSample" runat=server Text="Create Sample Data" Checked=false />
		</td>
	</tr>
</table>
