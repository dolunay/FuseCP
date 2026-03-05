<%@ Control language="C#" AutoEventWireup="false" %>
<div class="card">
  <div class="card-header">
    <h3 class="card-title"><asp:Image ID="imgModuleIcon" runat="server" alt="" CssClass="panel-icon"/>&nbsp;<asp:Label ID="lblModuleTitle" runat="server"></asp:Label></h3>
  </div>
  <asp:PlaceHolder ID="ContentPane" runat="server"/>
</div>