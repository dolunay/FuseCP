<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SetupControlPanelAccounts.ascx.cs" Inherits="FuseCP.Portal.SetupControlPanelAccounts" %>
<%@ Register src="UserControls/PasswordControl.ascx" tagname="PasswordControl" TagPrefix="fcp" %>
<div class="card-body form-horizontal">
	<p class="SubHead fcp-text-justify"><asp:Localize runat="server" meta:resourcekey="ScpaProcedureDescription" /></p>
	<table class="table table-borderless align-middle mb-0">
		<tr>
			<td class="SubHead text-end" ><asp:Localize runat="server" meta:resourcekey="lblUserNameA" Text="User Name:" /></td>
			<td class="NormalBold text-start"><asp:Localize runat="server" Text="serveradmin" /></td>
		</tr>
		<tr>
			<td class="SubHead text-nowrap align-top text-end"><asp:Localize runat="server" meta:resourcekey="lblPassword" Text="Password:" /></td>
			<td class="Normal align-middle text-start">
				<fcp:PasswordControl ID="PasswordControlA" runat="server" />
			</td>	
		</tr>
		<tr>
			<td class="SubHead text-end" ><asp:Localize runat="server" meta:resourcekey="lblUserNameA" Text="User Name:" /></td>
			<td class="NormalBold text-start"><asp:Localize ID="Localize2" runat="server" Text="admin" /></td>
		</tr>
		<tr>
			<td class="SubHead text-nowrap align-top text-end"><asp:Localize runat="server" meta:resourcekey="lblPassword" Text="Password:" /></td>
			<td class="Normal align-middle text-start">
				<fcp:PasswordControl ID="PasswordControlB" runat="server" />
			</td>	
		</tr>
		<tr>
			<td class="SubHead text-nowrap"></td>
			<td class="text-start">
				<asp:Button id="CompleteSetupButton" runat="server" meta:resourcekey="CompleteSetupButton" 
					Text="Complete Setup" CssClass="btn btn-primary" OnClick="CompleteSetupButton_Click" />
			</td>
		</tr>
	</table>
</div>
