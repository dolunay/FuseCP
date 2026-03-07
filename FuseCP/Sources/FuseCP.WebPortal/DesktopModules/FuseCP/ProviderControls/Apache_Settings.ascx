<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Apache_Settings.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.Apache_Settings" %>
<table class="table table-borderless align-middle mb-0 w-100">
		<tr>
			<td class="SubHead text-nowrap" >
			    <asp:Label ID="lblConfigPath" runat="server" meta:resourcekey="lblConfigPath" Text="Apache Configuration Path:"></asp:Label>
			</td>
			<td><asp:TextBox Runat="server" ID="txtConfigPath" Width="300px" CssClass="form-control"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="SubHead text-nowrap" >
			    <asp:Label ID="lblConfigFile" runat="server" meta:resourcekey="lblConfigFile" Text="Apache Configuration File:"></asp:Label>
			</td>
			<td><asp:TextBox Runat="server" ID="txtConfigFile" Width="300px" CssClass="form-control"></asp:TextBox></td>
		</tr>
		<tr>
			<td class="SubHead text-nowrap" >
			    <asp:Label ID="lblBinPath" runat="server" meta:resourcekey="lblBinPath" Text="Apache Bin Path:"></asp:Label>
			</td>
			<td><asp:TextBox Runat="server" ID="txtBinPath" Width="300px" CssClass="form-control"></asp:TextBox></td>
		</tr>
</table>

