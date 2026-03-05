<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CalculatePackagesBandwidth.ascx.cs" Inherits="FuseCP.Portal.ScheduleTaskControls.CalculatePackagesBandwidth" %>
	<table class="table table-borderless align-middle mb-0 w-100">
        <tr>
            <td class="SubHead text-nowrap">
				<asp:Label ID="lblSuspendOverusedSpaces" runat="server" meta:resourcekey="lblSuspendOverusedSpaces" Text="Suspend overused spaces?"></asp:Label>
			</td>
            <td class="Normal">
   				<asp:DropDownList ID="ddlSuspendOverusedSpaces" runat="server"  CssClass="NormalDropDown"></asp:DropDownList>
        </tr>
	</table>
