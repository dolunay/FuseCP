<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ExecuteSystemCommand.ascx.cs" Inherits="FuseCP.Portal.ScheduleTaskControls.ExecuteSystemCommand" %>
	<table class="table table-borderless align-middle mb-0 w-100">
        <tr>
            <td class="SubHead text-nowrap align-top">
				<asp:Label ID="lblServerName" runat="server" meta:resourcekey="lblServerName">Server Name: </asp:Label>
			</td>
            <td class="Normal">
   				<asp:TextBox ID="txtServerName" runat="server" Width="95%" CssClass="form-control" MaxLength="1000"></asp:TextBox>
        </tr>
        <tr>
            <td class="SubHead text-nowrap">
				<asp:Label ID="lblExecutablePath" runat="server" meta:resourcekey="lblExecutablePath" Text="Executable Path:"></asp:Label>
			</td>
            <td class="Normal">
   				<asp:TextBox ID="txtExecutablePath" runat="server" Width="95%" CssClass="form-control" MaxLength="1000"></asp:TextBox>
        </tr>
        <tr>
            <td class="SubHead text-nowrap">
				<asp:Label ID="lblExecutableParameters" runat="server" meta:resourcekey="lblExecutableParameters" Text="Executable Parameters:"></asp:Label>
			</td>
            <td class="Normal">
   				<asp:TextBox ID="txtExecutableParameters" runat="server" Width="95%" CssClass="form-control" MaxLength="1000"></asp:TextBox>
        </tr>
	</table>
