<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserPasswordExpirationNotificationView.ascx.cs" Inherits="FuseCP.Portal.ScheduleTaskControls.UserPasswordExpirationNotificationView" %>


<table class="table table-borderless align-middle mb-0 w-100" width="100%">
   <tr>
        <td class="SubHead text-nowrap">
            <asp:Label ID="lblDayBeforeNotify" runat="server" meta:resourcekey="lblDayBeforeNotify" Text="Notify before (days):"></asp:Label>
        </td>
        <td class="Normal" width="100%">
            <asp:TextBox ID="txtDaysBeforeNotify" runat="server" Width="95%" CssClass="form-control" MaxLength="1000"></asp:TextBox>
        </td>
    </tr>
</table>
