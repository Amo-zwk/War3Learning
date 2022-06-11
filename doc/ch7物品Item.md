# 物品
- 给单位附加额外属性,附加额外技能的道具
- 存储在单位的物品栏
- 状态(物品有一点的血量)
# api

## Types
```
item
itempool
itemtype
```
## Globals
```lua
EVENT_PLAYER_UNIT_DROP_ITEM = cj.ConvertPlayerUnitEvent(48)
EVENT_PLAYER_UNIT_PICKUP_ITEM = cj.ConvertPlayerUnitEvent(49)
EVENT_PLAYER_UNIT_USE_ITEM = cj.ConvertPlayerUnitEvent(50)

EVENT_UNIT_DROP_ITEM = cj.ConvertUnitEvent(85)
EVENT_UNIT_PICKUP_ITEM = cj.ConvertUnitEvent(86)
EVENT_UNIT_USE_ITEM = cj.ConvertUnitEvent(87)
EVENT_UNIT_LOADED = cj.ConvertUnitEvent(88)

EVENT_PLAYER_UNIT_SELL_ITEM = cj.ConvertPlayerUnitEvent(271)
EVENT_PLAYER_UNIT_PAWN_ITEM = cj.ConvertPlayerUnitEvent(277)

EVENT_UNIT_SELL_ITEM = cj.ConvertUnitEvent(288)
EVENT_UNIT_PAWN_ITEM = cj.ConvertUnitEvent(294)


ITEM_TYPE_PERMANENT = cj.ConvertItemType(0)
ITEM_TYPE_CHARGED = cj.ConvertItemType(1)
ITEM_TYPE_POWERUP = cj.ConvertItemType(2)
ITEM_TYPE_ARTIFACT = cj.ConvertItemType(3)
ITEM_TYPE_PURCHASABLE = cj.ConvertItemType(4)
ITEM_TYPE_CAMPAIGN = cj.ConvertItemType(5)
ITEM_TYPE_MISCELLANEOUS = cj.ConvertItemType(6)
ITEM_TYPE_UNKNOWN = cj.ConvertItemType(7)
ITEM_TYPE_ANY = cj.ConvertItemType(8)
ITEM_TYPE_TOME = cj.ConvertItemType(2)
```
## Common
```lua
cj.AddItemToAllStock = JassCommon["AddItemToAllStock"]
cj.AddItemToStock = JassCommon["AddItemToStock"]

cj.ChooseRandomItem = JassCommon["ChooseRandomItem"]
cj.ChooseRandomItemEx = JassCommon["ChooseRandomItemEx"]

cj.ConvertItemType = JassCommon["ConvertItemType"]

cj.CreateItem = JassCommon["CreateItem"]
cj.CreateItemPool = JassCommon["CreateItemPool"]'
cj.DestroyItemPool = JassCommon["DestroyItemPool"]

cj.EnumItemsInRect = JassCommon["EnumItemsInRect"]
cj.GetEnumItem = JassCommon["GetEnumItem"]
cj.GetFilterItem = JassCommon["GetFilterItem"]


cj.GetItemCharges = JassCommon["GetItemCharges"]
cj.GetItemLevel = JassCommon["GetItemLevel"]
cj.GetItemName = JassCommon["GetItemName"]
cj.GetItemPlayer = JassCommon["GetItemPlayer"]
cj.GetItemType = JassCommon["GetItemType"]
cj.GetItemTypeId = JassCommon["GetItemTypeId"]
cj.GetItemUserData = JassCommon["GetItemUserData"]
cj.GetItemX = JassCommon["GetItemX"]
cj.GetItemY = JassCommon["GetItemY"]

cj.GetManipulatedItem = JassCommon["GetManipulatedItem"]
cj.GetOrderTargetItem = JassCommon["GetOrderTargetItem"]

cj.GetSoldItem = JassCommon["GetSoldItem"]

cj.GetSpellTargetItem = JassCommon["GetSpellTargetItem"]

cj.IsItemIdPawnable = JassCommon["IsItemIdPawnable"]
cj.IsItemIdPowerup = JassCommon["IsItemIdPowerup"]
cj.IsItemIdSellable = JassCommon["IsItemIdSellable"]
cj.IsItemInvulnerable = JassCommon["IsItemInvulnerable"]
cj.IsItemOwned = JassCommon["IsItemOwned"]
cj.IsItemPawnable = JassCommon["IsItemPawnable"]
cj.IsItemPowerup = JassCommon["IsItemPowerup"]
cj.IsItemSellable = JassCommon["IsItemSellable"]
cj.IsItemVisible = JassCommon["IsItemVisible"]

cj.IsQuestItemCompleted = JassCommon["IsQuestItemCompleted"]


cj.ItemPoolAddItemType = JassCommon["ItemPoolAddItemType"]
cj.ItemPoolRemoveItemType = JassCommon["ItemPoolRemoveItemType"]

cj.LeaderboardAddItem = JassCommon["LeaderboardAddItem"]

cj.LeaderboardGetItemCount = JassCommon["LeaderboardGetItemCount"]
cj.LeaderboardHasPlayerItem = JassCommon["LeaderboardHasPlayerItem"]
cj.LeaderboardRemoveItem = JassCommon["LeaderboardRemoveItem"]

cj.LeaderboardSetItemLabel = JassCommon["LeaderboardSetItemLabel"]
cj.LeaderboardSetItemLabelColor = JassCommon["LeaderboardSetItemLabelColor"]
cj.LeaderboardSetItemStyle = JassCommon["LeaderboardSetItemStyle"]
cj.LeaderboardSetItemValue = JassCommon["LeaderboardSetItemValue"]
cj.LeaderboardSetItemValueColor = JassCommon["LeaderboardSetItemValueColor"]

cj.LeaderboardSortItemsByLabel = JassCommon["LeaderboardSortItemsByLabel"]
cj.LeaderboardSortItemsByPlayer = JassCommon["LeaderboardSortItemsByPlayer"]
cj.LeaderboardSortItemsByValue = JassCommon["LeaderboardSortItemsByValue"]

cj.LoadItemHandle = JassCommon["LoadItemHandle"]
cj.LoadItemPoolHandle = JassCommon["LoadItemPoolHandle"]

cj.LoadMultiboardItemHandle = JassCommon["LoadMultiboardItemHandle"]
cj.LoadQuestItemHandle = JassCommon["LoadQuestItemHandle"]

cj.MultiboardGetItem = JassCommon["MultiboardGetItem"]

cj.MultiboardSetItemIcon = JassCommon["MultiboardSetItemIcon"]
cj.MultiboardSetItemStyle = JassCommon["MultiboardSetItemStyle"]
cj.MultiboardSetItemValue = JassCommon["MultiboardSetItemValue"]
cj.MultiboardSetItemValueColor = JassCommon["MultiboardSetItemValueColor"]
cj.MultiboardSetItemWidth = JassCommon["MultiboardSetItemWidth"]
cj.MultiboardSetItemsIcon = JassCommon["MultiboardSetItemsIcon"]
cj.MultiboardSetItemsStyle = JassCommon["MultiboardSetItemsStyle"]
cj.MultiboardSetItemsValue = JassCommon["MultiboardSetItemsValue"]
cj.MultiboardSetItemsValueColor = JassCommon["MultiboardSetItemsValueColor"]
cj.MultiboardSetItemsWidth = JassCommon["MultiboardSetItemsWidth"]


cj.PlaceRandomItem = JassCommon["PlaceRandomItem"]


cj.QuestCreateItem = JassCommon["QuestCreateItem"]
cj.QuestItemSetCompleted = JassCommon["QuestItemSetCompleted"]
cj.QuestItemSetDescription = JassCommon["QuestItemSetDescription"]


cj.RemoveItem = JassCommon["RemoveItem"]
cj.RemoveItemFromAllStock = JassCommon["RemoveItemFromAllStock"]
cj.RemoveItemFromStock = JassCommon["RemoveItemFromStock"]

cj.SaveItemHandle = JassCommon["SaveItemHandle"]
cj.SaveItemPoolHandle = JassCommon["SaveItemPoolHandle"]

cj.SaveMultiboardItemHandle = JassCommon["SaveMultiboardItemHandle"]
cj.SaveQuestItemHandle = JassCommon["SaveQuestItemHandle"]

cj.SetAllItemTypeSlots = JassCommon["SetAllItemTypeSlots"]


cj.SetItemCharges = JassCommon["SetItemCharges"]
cj.SetItemDropID = JassCommon["SetItemDropID"]
cj.SetItemDropOnDeath = JassCommon["SetItemDropOnDeath"]
cj.SetItemDroppable = JassCommon["SetItemDroppable"]
cj.SetItemInvulnerable = JassCommon["SetItemInvulnerable"]
cj.SetItemPawnable = JassCommon["SetItemPawnable"]
cj.SetItemPlayer = JassCommon["SetItemPlayer"]
cj.SetItemPosition = JassCommon["SetItemPosition"]
cj.SetItemTypeSlots = JassCommon["SetItemTypeSlots"]
cj.SetItemUserData = JassCommon["SetItemUserData"]
cj.SetItemVisible = JassCommon["SetItemVisible"]

cj.UnitAddItem = JassCommon["UnitAddItem"]
cj.UnitAddItemById = JassCommon["UnitAddItemById"]
cj.UnitAddItemToSlotById = JassCommon["UnitAddItemToSlotById"]

cj.UnitDropItemPoint = JassCommon["UnitDropItemPoint"]
cj.UnitDropItemSlot = JassCommon["UnitDropItemSlot"]
cj.UnitDropItemTarget = JassCommon["UnitDropItemTarget"]

cj.UnitHasItem = JassCommon["UnitHasItem"]
cj.UnitItemInSlot = JassCommon["UnitItemInSlot"]

cj.UnitRemoveItem = JassCommon["UnitRemoveItem"]
cj.UnitRemoveItemFromSlot = JassCommon["UnitRemoveItemFromSlot"]

cj.UnitUseItem = JassCommon["UnitUseItem"]
cj.UnitUseItemPoint = JassCommon["UnitUseItemPoint"]
cj.UnitUseItemTarget = JassCommon["UnitUseItemTarget"]

```
## Japi
```
EXSetItemDataString
DzDotaInfo_Item_HE
DzAPI_UnitType_CountUnitTypeDataArrayItemID
EXGetItemDataString
DzDotaInfo_Item
DzDotaInfo_Item_TM


DzEvent_Item_Drop
DzEvent_Item_Pickup
DzEvent_Item_Use
DzEvent_Item_Sell

DzAPI_Map_HasMallItem
DzAPI_Map_ChangeStoreItemCoolDown

DzAPI_Map_UseConsumablesItem

DzAPI_UnitType_ResizeUnitTypeDataArrayItemID
DzAPI_UnitType_GetUnitTypeDataArrayItemID
DzAPI_UnitType_SetUnitTypeDataArrayItemID


```