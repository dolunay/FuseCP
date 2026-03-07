<%@ Control Language="c#" AutoEventWireup="true" %>
<%@ Implements interface="FuseCP.Portal.IWebInstallerSettings" %>
<%@ Import namespace="FuseCP.EnterpriseServer" %>
<script language="C#" runat="server">
		void Page_Load()
		{
		}
		
		public void GetSettings(InstallationInfo inst)
		{
			if(chkSample.Checked)
				inst["InstallSampleData"] = "True";
		}
</script>
<table class="table table-borderless align-middle mb-0">
	<tr>
		<td class="SubHead text-nowrap align-top" >
			Install sample store data:
		</td>
		<td class="NormalBold">
			<asp:CheckBox id="chkSample" runat="server" CssClass="NormalBold" Text="Yes"></asp:CheckBox>
		</td>
	</tr>
	<tr>
		<td>
		
		</td>
		<td class=Normal>
			Ticking this checkbox allows you to upload the sample data into your store database.
		</td>
	</tr>
</table>
