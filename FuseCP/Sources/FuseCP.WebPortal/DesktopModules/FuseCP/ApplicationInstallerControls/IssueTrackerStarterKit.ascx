<%@ Control Language="c#" AutoEventWireup="true" %>
<%@ Implements interface="FuseCP.Portal.IWebInstallerSettings" %>
<%@ Import namespace="FuseCP.EnterpriseServer" %>
<script language="C#" runat="server">
		void Page_Load()
		{
		}
		
		public void GetSettings(InstallationInfo inst)
		{
			inst["admin.username"] = txtUsername.Text;
			inst["admin.password"] = txtPassword.Text;
		}
</script>
<table class="table table-borderless align-middle mb-0" >
	<tr>
		<td class=SubHead colspan=2>
			Enter the username and password you would like to use for the administrator account
			of your IssueTracker application:
		</td>
	</tr>
	<tr>
		<td class="SubHead text-nowrap" >Username:</td>
		<td class="Normal" >
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
</table>
