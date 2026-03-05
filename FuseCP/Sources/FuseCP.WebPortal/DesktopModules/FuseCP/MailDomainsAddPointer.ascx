<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MailDomainsAddPointer.ascx.cs" Inherits="FuseCP.Portal.MailDomainsAddPointer" %>
<%@ Register Src="DomainsSelectDomainControl.ascx" TagName="DomainsSelectDomainControl" TagPrefix="uc1" %>
<div class="card-body form-horizontal">
    <table cellspacing="0" cellpadding="4" width="100%">
	    <tr>
		    <td class="SubHead" width="200" nowrap><asp:Label ID="lblDomainName" runat="server" meta:resourcekey="lblDomainName" Text="Domain name:"></asp:Label></td>
		    <td width="100%">
                <uc1:DomainsSelectDomainControl ID="domainsSelectDomainControl" runat="server"
                    HideMailDomains="true" HideDomainsSubDomains="false" HidePreviewDomain="false" HideDomainPointers="true" HideIdnDomains="True"/>
		    </td>
	    </tr>
    </table>
</div>
<div class="card-footer text-end">
    <asp:LinkButton id="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel"/> </asp:LinkButton>&nbsp;
    <asp:LinkButton id="btnAdd" CssClass="btn btn-success" runat="server" OnClick="btnAdd_Click"> <i class="bi bi-check-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAdd"/> </asp:LinkButton>
</div>

