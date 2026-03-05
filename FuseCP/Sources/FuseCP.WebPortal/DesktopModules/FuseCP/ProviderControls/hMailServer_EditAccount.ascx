<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="hMailServer_EditAccount.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.hMailServer_EditAccount" %>
<%@ Register TagPrefix="fcp" TagName="CollapsiblePanel" Src="../UserControls/CollapsiblePanel.ascx" %>
<fcp:CollapsiblePanel id="secAutoresponder" runat="server"
    TargetControlID="AutoresponderPanel" meta:resourcekey="secAutoresponder" Text="Autoresponder">
</fcp:CollapsiblePanel>
<asp:Panel ID="AutoresponderPanel" runat="server" Height="0" style="overflow:hidden;">
    <table class="table table-borderless align-middle mb-0 w-100">
	    <tr>
		    <td class="SubHead text-nowrap"><asp:Label ID="lblResponderEnabled" runat="server" meta:resourcekey="lblResponderEnabled" Text="Enable autoresponder:"></asp:Label></td>
		    <td class="normal">
			    <asp:CheckBox ID="chkResponderEnabled" Runat="server" meta:resourcekey="chkResponderEnabled" Text="Yes"></asp:CheckBox>
		    </td>
	    </tr>
	    <tr>
		    <td class="SubHead"><asp:Label ID="lblSubject" runat="server" meta:resourcekey="lblSubject" Text="Subject:"></asp:Label></td>
		    <td class="normal align-top">
			    <asp:TextBox id="txtSubject" runat="server" Width="400px" CssClass="form-control" MaxLength="255"></asp:TextBox>
		    </td>
	    </tr>
	    <tr>
		    <td class="SubHead align-top"><asp:Label ID="lblMessage" runat="server" meta:resourcekey="lblMessage" Text="Message:"></asp:Label></td>
		    <td class="normal">
			    <asp:TextBox id="txtMessage" runat="server" Width="400px" TextMode="MultiLine" Rows="5" CssClass="form-control" MaxLength="255"></asp:TextBox>
		    </td>
	    </tr>
    </table>
</asp:Panel>

<fcp:CollapsiblePanel id="secForwarding" runat="server"
    TargetControlID="ForwardingPanel" meta:resourcekey="secForwarding" Text="Mail Forwarding">
</fcp:CollapsiblePanel>
<asp:Panel ID="ForwardingPanel" runat="server" Height="0" style="overflow:hidden;">
    <table class="table table-borderless align-middle mb-0 w-100">
	    <tr>
		    <td class="SubHead text-nowrap"><asp:Label ID="lblForwardTo" runat="server" meta:resourcekey="lblForwardTo" Text="Forward mail to address:"></asp:Label></td>
		    <td class="normal align-top">
			    <asp:TextBox id="txtForward" runat="server" Width="200px" CssClass="form-control" MaxLength="255"></asp:TextBox>
		    </td>
	    </tr>
    </table>
</asp:Panel>
