<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditItemComments.ascx.cs" Inherits="FuseCP.Portal.EditItemComments" %>
<%@ Register TagPrefix="uc2" TagName="UserDetails" Src="UserDetails.ascx"  %>

<asp:UpdatePanel runat="server" ID="commentsUpdatePanel" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>

    <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False"
    ShowHeader="false" DataKeyNames="CommentID"
    CssSelectorClass="card-body"
    EmptyDataText="gvComments" OnRowDeleting="gvComments_RowDeleting">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class="float-end">
                        <asp:ImageButton ID="btnDelete" SkinID="DeleteSmall" CommandName="delete" runat="server" Text="Delete" meta:resourcekey="btnDelete" />
                    </div>
                    <div class="Small">                                
                         <uc2:UserDetails ID="userDetails" runat="server"
                            UserID='<%# Eval("UserID") %>'
                            Username='<%# Eval("Username") %>' />
                            
                            <asp:Label ID="lblCommented" runat="server" meta:resourcekey="lblCommented"></asp:Label>
                            
                            <%# Eval("CreatedDate") %>
                    </div>
                    <div class="FormRow">
                        <%# WrapComment((string)Eval("CommentText")) %>
                    </div>
                    
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Panel id="AddCommentPanel" runat="server">
        <div class="card-body">
        <asp:TextBox ID="txtComments" runat="server" CssClass="form-control" Rows="3"
            TextMode="MultiLine"></asp:TextBox>
            </div>
            <div class="card-footer text-end">
                <asp:LinkButton ID="btnAdd" runat="server" CssClass="btn btn-primary" OnClick="btnAdd_Click" ValidationGroup="AddItemComment" >
                    <i class="bi bi-chat-left-text">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAdd"/>
                </asp:LinkButton>
                 <asp:RequiredFieldValidator ID="valRequireComment" runat="server" ControlToValidate="txtComments"
                    ErrorMessage="*" ValidationGroup="AddItemComment" meta:resourcekey="valRequireComment"></asp:RequiredFieldValidator>
            </div>
    </asp:Panel>

    </ContentTemplate>
</asp:UpdatePanel>
