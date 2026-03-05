<%@ Control Language="c#" AutoEventWireup="true" %>
<%@ Implements interface="FuseCP.Portal.IWebInstallerSettings" %>
<%@ Import namespace="FuseCP.EnterpriseServer" %>
<%@ Import Namespace="System.Text" %>

<script language="C#" runat="server">
		void Page_Load()
		{
		}
		
		public void GetSettings(InstallationInfo inst)
		{
			inst["fcp.portalname"] = txtPortalName.Text;
			inst["fcp.enterpriseserver"] = txtEsURL.Text;
		}
</script>
<table class="table table-borderless align-middle mb-0">
	<tr>
		<td class="SubHead text-nowrap" style="width: 200px;">Portal Name:</td>
		<td class="Normal">
			<asp:textbox id="txtPortalName" runat="server" CssClass="form-control" Width="200px">FuseCP</asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="SubHead text-nowrap" style="width: 200px;">Enterprise Server URL:</td>
		<td class="Normal">
			<asp:textbox id="txtEsURL" runat="server" CssClass="form-control" Width="200px">http://127.0.0.1:9002</asp:textbox>
		</td>
	</tr>
</table>
