<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CollapsiblePanel.ascx.cs" Inherits="FuseCP.Portal.CollapsiblePanel" %>
<asp:Panel ID="HeaderPanel" runat="server" style="cursor: pointer">
    <table class="Shevron">
		<tr>
      <td class="text-nowrap fcp-pr-5"><asp:Label ID="lblTitle" runat="server"></asp:Label></td>
			<td class="ShevronLine"></td>
			<td class="fcp-ps-5"><asp:Image ID="ToggleImage" runat="server" Height="4" ImageUrl="~/Images/shevron_collapse.gif" /></td>
		</tr>
    </table>
</asp:Panel>
<ajaxToolkit:CollapsiblePanelExtender ID="cpe" runat="Server" OnResolveControlID="cpe_ResolveControlID"
        TargetControlID="CpeContentPanel"
        ExpandControlID="HeaderPanel"
        CollapseControlID="HeaderPanel"
        Collapsed="False"        
        ExpandDirection="Vertical"
        ImageControlID="ToggleImage"
        ExpandedImage="~/Images/shevron_collapse.gif"
        ExpandedText="Collapse"
        CollapsedImage="~/Images/shevron_expand.gif"
        CollapsedText="Expand"
        SuppressPostBack="true" /> 
