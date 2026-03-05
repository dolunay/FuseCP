<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Sps20_Settings.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.Sps20_Settings" %>
<%@ Register Src="Common_ActiveDirectoryIntegration.ascx" TagName="ActiveDirectoryIntegration" TagPrefix="uc1" %>
<table class="table table-borderless align-middle mb-0 w-100" width="100%">
	<tr>
	    <td class="SubHead align-top">
	        <asp:Label ID="lblADIntegration" runat="server" meta:resourcekey="lblADIntegration" Text="Active Directory Integration:"></asp:Label>
	    </td>
	    <td class="Normal align-top">
            <uc1:ActiveDirectoryIntegration ID="ActiveDirectoryIntegration" runat="server" />

        </td>
	</tr>
	<tr>
		<td class="SubHead">
		    <asp:Label ID="lblExclusiveNTLM" runat="server" meta:resourcekey="lblExclusiveNTLM" Text="Use NTLM authentication only"></asp:Label>
		</td>
		<td class="Normal">
			<asp:CheckBox ID="chkExclusiveNTLM" runat="server" meta:resourcekey="chkExclusiveNTLM" Text="Yes" Checked="true" />
		</td>
	</tr>
</table>
