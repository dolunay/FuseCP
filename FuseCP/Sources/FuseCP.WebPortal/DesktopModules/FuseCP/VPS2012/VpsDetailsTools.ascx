<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VpsDetailsTools.ascx.cs" Inherits="FuseCP.Portal.VPS2012.VpsDetailsTools" %>
<%@ Register Src="../UserControls/SimpleMessageBox.ascx" TagName="SimpleMessageBox" TagPrefix="fcp" %>
<%@ Register Src="UserControls/ServerTabs.ascx" TagName="ServerTabs" TagPrefix="fcp" %>
<%@ Register Src="UserControls/Menu.ascx" TagName="Menu" TagPrefix="fcp" %>
<%@ Register Src="UserControls/Breadcrumb.ascx" TagName="Breadcrumb" TagPrefix="fcp" %>
<%@ Register Src="UserControls/FormTitle.ascx" TagName="FormTitle" TagPrefix="fcp" %>

	    <div class="Content">
		    <div class="Center">
			    <div class="card-body form-horizontal">
			        <fcp:ServerTabs id="tabs" runat="server" SelectedTab="vps_tools" />	
                    <fcp:SimpleMessageBox id="messageBox" runat="server" />
                    
				    <table cellspacing="15">
				        <%-- <tr>
				            <td>
				                <asp:LinkButton id="btnReinstall" CssClass="btn btn-success" runat="server" CausesValidation="false" onclick="btnReinstall_Click"> <i class="bi bi-check-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnReinstallText"/> </asp:LinkButton>
				            </td>
				            <td>
				                <asp:Localize ID="locReinstall" runat="server" meta:resourcekey="locReinstall" Text="Performs..."></asp:Localize>
				            </td>
				        </tr>--%>
				        <tr>
				            <td>
				                <asp:LinkButton id="btnDelete" CssClass="btn btn-danger" runat="server" CausesValidation="false" onclick="btnDelete_Click"> <i class="bi bi-trash">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnDeleteText"/> </asp:LinkButton>
				            </td>
				            <td>
				                <asp:Localize ID="locDelete" runat="server" meta:resourcekey="locDelete" Text="Performs..."></asp:Localize>
				            </td>
				        </tr>
				    </table>
			    </div>
		    </div>
	    </div>
