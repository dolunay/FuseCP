<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileZilla_Settings.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.FileZilla_Settings" %>
<table class="table table-borderless align-middle mb-0 w-100">
	<tr>
		<td class="SubHead" >
		    <asp:Label ID="lblBuildUncFilesPath" runat="server" meta:resourcekey="lblBuildUncFilesPath" Text="Build UNC Path to Space Files:"></asp:Label>
		</td>
		<td>
			<asp:CheckBox ID="chkBuildUncFilesPath" runat="server" meta:resourcekey="chkBuildUncFilesPath" Text="Yes" />
		</td>
	</tr>
</table>
