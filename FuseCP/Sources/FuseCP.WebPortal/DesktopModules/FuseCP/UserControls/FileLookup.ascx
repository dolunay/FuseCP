<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileLookup.ascx.cs" Inherits="FuseCP.Portal.FileLookup" %>
<asp:TextBox ID="txtFile" runat="server" CssClass="form-control" Width="300px"></asp:TextBox>
<asp:RequiredFieldValidator ID="valRequireFile" runat="server" meta:resourcekey="valRequireFile" ControlToValidate="txtFile"
    ErrorMessage="*"></asp:RequiredFieldValidator>
<br />
<asp:Panel ID="pnlLookup" runat="server" style="display: none" CssClass="Toolbox">
<div class="fcp-log-scroll-alt">
    <div class="float-end">
	    <asp:UpdateProgress ID="treeProgress" runat="server"
	        AssociatedUpdatePanelID="TreeUpdatePanel" DynamicLayout="true">
	        <ProgressTemplate>
	            <asp:Image ID="imgIndicator" runat="server" SkinID="AjaxIndicator" />
	        </ProgressTemplate>
	    </asp:UpdateProgress>
    </div>
    <asp:UpdatePanel ID="TreeUpdatePanel" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
        <ContentTemplate>
		    <asp:treeview runat="server" id="DNNTree" populatenodesfromclient="true"
			    showexpandcollapse="true" expanddepth="0" ontreenodepopulate="DNNTree_TreeNodePopulate"
			    onselectednodechanged="DNNTree_SelectedNodeChanged" NodeIndent="10">
			    <rootnodestyle cssclass="FileManagerTreeNode" />
			    <nodestyle cssclass="FileManagerTreeNode" />
			    <leafnodestyle cssclass="FileManagerTreeNode" />
			    <parentnodestyle cssclass="FileManagerTreeNode" />
			    <selectednodestyle cssclass="FileManagerTreeNodeSelected" />
		    </asp:treeview>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
</asp:Panel>

<ajaxToolkit:PopupControlExtender ID="PopupControlExtender1" runat="server" TargetControlID="txtFile" PopupControlID="pnlLookup" Position="Bottom" />
<ajaxToolkit:DropShadowExtender  ID="DropShadowExtender1" runat="server" TargetControlID="pnlLookup" TrackPosition="true" Opacity="0.4" />
