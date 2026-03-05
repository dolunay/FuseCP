<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SmarterMail60_EditDomain_Throttling.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.SmarterMail60_EditDomain_Throttling" %>
<table class="table table-borderless align-middle mb-0">
    <tr>
        <td class="text-end"><asp:Label ID="lbMessagesPerHour" runat="server" meta:resourcekey="lbMessagesPerHour" /></td>
        <td>
                <asp:TextBox runat="server"  ID="txtMessagesPerHour" Text="0" Width="80px" CssClass="form-control" />
                <asp:RangeValidator Type="Integer" runat="server" ID="valMessagesPerHour" ControlToValidate="txtMessagesPerHour"
                    MinimumValue="0" Display="Dynamic" />
                <asp:RequiredFieldValidator ID="reqValMessagesPerHour" runat="server" ControlToValidate="txtMessagesPerHour"
                    Display="Dynamic" />
         </td>
         <td class="text-start">
            <asp:CheckBox runat="server" ID="cbMessagesPerHour"  />
        </td>
        <td class="text-start"><asp:Label ID="lbMessagesPerHourEnabled" runat="server" meta:resourcekey="lbEnabled" /></td>
    </tr>
    <tr>
        <td class="text-end"><asp:Label ID="lbBandwidthPerHour" runat="server" meta:resourcekey="lbBandwidthPerHour" /></td>
        <td>
                <asp:TextBox runat="server"  ID="txtBandwidthPerHour" Text="0" Width="80px" CssClass="form-control" />
                <asp:RangeValidator Type="Integer" runat="server" ID="valBandwidthPerHour" ControlToValidate="txtBandwidthPerHour"
                    MinimumValue="0" Display="Dynamic" />
                <asp:RequiredFieldValidator ID="reqValBandwidth" runat="server" ControlToValidate="txtBandwidthPerHour"
                    Display="Dynamic" />
         </td>
         <td class="text-start">
            <asp:CheckBox runat="server" ID="cbBandwidthPerHour"/>
        </td>
        <td class="text-start"><asp:Label ID="lbBandwidthPerHourEnabled" runat="server" meta:resourcekey="lbEnabled" /></td>
    </tr>
    <tr>
        <td class="text-end"><asp:Label ID="lbBouncesPerHour" runat="server" meta:resourcekey="lbBouncesPerHour" /></td>
        <td>
                <asp:TextBox runat="server"  ID="txtBouncesPerHour" Text="0" Width="80px" CssClass="form-control" />
                <asp:RangeValidator Type="Integer" runat="server" ID="valBouncesPerHour" ControlToValidate="txtBouncesPerHour"
                    MinimumValue="0" Display="None" />
                <asp:RequiredFieldValidator ID="reqValBouncesPerHour" runat="server" ControlToValidate="txtBouncesPerHour"
                    Display="None" />
         </td>
         <td class="text-start">
            <asp:CheckBox runat="server" ID="cbBouncesPerHour" />
        </td>
        <td class="text-start"><asp:Label ID="lbBouncesPerHourEnabled"  runat="server" meta:resourcekey="lbEnabled" /></td>
    </tr>
</table>

