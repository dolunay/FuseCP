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
			inst["ObjectQualifier"] = txtQualifier.Text.Trim();
			inst["ObjectQualifierNormalized"] = (txtQualifier.Text.Trim() == "") ? "" : txtQualifier.Text.Trim() + "_";
			inst["admin.username"] = txtUsername.Text;
            	inst["admin.password"] = MD5(txtPassword.Text);
			inst["admin.email"] = txtEmail.Text;
			inst["InstallDate"] = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss");

            if (chkCreateSimple.Checked)
                inst["CreateSimple"] = "Yes";
			
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
<table class="table table-borderless align-middle mb-0" style="width: 100%;">
		<tr>
		<td class="SubHead text-nowrap" style="width: 200px;">
			Database objects qualifier:
		</td>
		<td style="width: 100%;">
			<asp:TextBox id="txtQualifier" runat="server" CssClass="form-control" Text="" MaxLength="5"
				Columns="5"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td></td>
		<td class="Normal">
			Several instances of Joomla can work with the same database simultaneously. 
			They are separated by mean of database object qualifiers which are just 
			prefixes for database tables, stored procedures, etc.<br/><br/>
			So, if you install your first instance of Joomla on the selected database, 
			leave this field blank; otherwise, specify some value, for example 'jos'.
		</td>
	</tr>
	<tr>
		<td class=SubHead colspan=2>
			Enter the username and password you would like to use for the administrator account
			of your new Joomla site:
		</td>
	</tr>
	<tr>
		<td class="SubHead text-nowrap" style="width: 200px;">Username:</td>
		<td class="Normal" style="width: 100%;">
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
		<td class="SubHead text-nowrap" style="width: 200px;">E-Mail:</td>
		<td class="Normal" style="width: 100%;">
			<asp:textbox id="txtEmail" runat="server" CssClass=form-control>admin@site.com</asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead">&nbsp;</td>
		<td class="NormalBold">
			<asp:Checkbox id="chkCreateSimple" runat=server Text="Create Sample Data" Checked=false />
		</td>
	</tr>
</table>
