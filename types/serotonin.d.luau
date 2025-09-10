type DrawingFont = "ConsolasBold" | "SmallestPixel" | "Verdana" | "Tahoma"

type MouseButton = "leftmouse" | "rightmouse" | "middlemouse" | "mouse4" | "mouse5" | "VK_LBUTTON" | "VK_RBUTTON" | "VK_MBUTTON" | "VK_XBUTTON1" | "VK_XBUTTON2"

type UiContainerOptions = {
    autosize: boolean?,
    next: boolean?,
    halfsize: boolean?,
    visible: boolean?
}

type EventTypes = "onUpdate" | "onSlowUpdate" | "onPaint" | "shutdown" | "newPlace"

declare class Vector3
    X: number?
    Y: number?
    Z: number?
    function Abs(self): Vector3
    function Ceil(self): Vector3
    function Floor(self): Vector3
    function Sign(self): Vector3
    function Cross(self, other: Vector3): Vector3
    function Dot(self, other: Vector3): number
    function Lerp(self, goal: Vector3, alpha: number): Vector3
    function Angle(self, other: Vector3, axis: Vector3?): number
    function FuzzyEq(self, other: Vector3, epsilon: number?): boolean
    function Max(self, other: Vector3): Vector3
    function Min(self, other: Vector3): Vector3
end

declare class Color3
    R: number?
    G: number?
    B: number?

    fromRGB: (r: number?, g: number?, b: number?) -> Color3
    fromHSV: (h: number?, s: number?, v: number?) -> Color3
    fromHex: (hex: string) -> Color3
    function Lerp(self, goal: Color3, alpha: number): Color3
    function ToHex(self): string
    function ToHSV(self): (number, number, number)
end

declare Vector3: Vector3
declare Color3: Color3

declare class SerotoninAttribute
    Name: string
    TypeName: string
    Value: any
end

declare class SerotoninInstance
    Parent: SerotoninInstance?
    Name: string
    ClassName: string
    Address: string
    function GetChildren(self): { SerotoninInstance }
    function IsA(self, className: string): boolean
    function GetDescendants(self): { SerotoninInstance }
    function FindFirstChild(self, childName: string): SerotoninInstance?
    function FindFirstChildOfClass(self, className: string): SerotoninInstance?
    function IsDescendantOf(self, ancestor: SerotoninInstance): boolean
    function IsAncestorOf(self, ancestor: SerotoninInstance): boolean
    function FindFirstAncestor(self, ancestorName: string): SerotoninInstance?
    function FindFirstAncestorOfClass(self, className: string): SerotoninInstance?
    function FindFirstDescendant(self, descendantName: string): SerotoninInstance?
    function FindFirstDescendantOfClass(self, className: string): SerotoninInstance?
    function GetAttributes(self): { SerotoninAttribute }
    function GetAttribute(self, name: string): SerotoninAttribute?
    function GetFirstAttributeOfType(self, typeName: string): SerotoninAttribute?
end

declare class SerotoninHumanoid extends SerotoninInstance
    Health: number
    MaxHealth: number
end

declare class SerotoninCharacter extends SerotoninInstance
    Humanoid: SerotoninHumanoid
end

declare class SerotoninPlayer extends SerotoninInstance
    UserID: string
    Team: string?
    Character: SerotoninCharacter?
end

declare class SerotoninLocalPlayer extends SerotoninPlayer
    CameraMaxZoomDistance: number
end

declare class SerotoninHighlight extends SerotoninInstance
    function SetHighlightOnTop(self): nil
    function SetHighlightTransparency(self, transparency: number): nil
end

declare class SerotoninPart extends SerotoninInstance

end

declare class SerotoninGame extends SerotoninInstance
    Workspace: Workspace
    Players: Players
    DataModel: DataModel
    LocalPlayer: SerotoninLocalPlayer
    CameraPosition: Vector3
    GetService: (serviceName: string) -> SerotoninInstance
    SilentAim: (x: number, y: number) -> nil
    PlayerWhitelist: (name: string) -> nil
end

declare class SerotoninBoundingBox
    x: number
    y: number
    w: number
    h: number
end

declare class SerotoninEntity
    Name: string
    DisplayName: string
    UserId: number
    Team: string
    Weapon: string
    Velocity: Vector3
    Health: number
    MaxHealth: number
    IsAlive: boolean
    IsEnemy: boolean
    IsVisible: boolean
    IsWhitelisted: boolean
    BoundingBox: SerotoninBoundingBox
    TeamColor: Color3
    
    function GetBonePosition(self, boneName: string): Vector3?
    function GetBoneInstance(self, boneName: string): SerotoninPart?
    function GetBoneSize(self, boneName: string): Vector3?
    -- 3x3 matrix, todo: represent this properly
    function GetBoneRotation(self, boneName: string): { number }?
end

declare class SerotoninEntityList
    -- This doesn't actually return an index like in the docs, rather it returns the entity userdata
    -- https://serotonin-1.gitbook.io/serotonin-docs/api/entity/players#data-model-1
    GetLocalPlayer: () -> SerotoninEntity
    
    GetPlayers: (onlyEnemies: boolean?) -> { SerotoninEntity }
    GetParts: () -> { number }

    AddModel: (key: string, data: { any }) -> boolean
    RemoveModel: (key: string) -> boolean
    ClearModels: () -> boolean
    EditModel: (key: string, data: { any }) -> boolean

    -- unable to test these, GetParts always returns 0
    --[[getPartPosition: (index: number) -> Vector3?
    getPartSize: (index: number) -> Vector3?
    getPartRotation: (index: number) -> { number }?]]
end

declare class SerotoninDrawing
    Line: (x1: number, y1: number, x2: number, y2: number, color: Color3, alpha: number, thickness: number) -> nil
    Rect: (x: number, y: number, w: number, h: number, color: Color3, alpha: number?, thickness: number?, rounding: number?) -> nil
    RectFilled: (x: number, y: number, w: number, h: number, color: Color3, alpha: number?, rounding: number?) -> nil
    Circle: (x: number, y: number, radius: number, color: Color3, alpha: number?, thickness: number?, segments: number?) -> nil
    CircleFilled: (x: number, y: number, radius: number, color: Color3, alpha: number?, segments: number?) -> nil
    Triangle: (x1: number, y1: number, x2: number, y2: number, x3: number, y3: number, color: Color3, alpha: number?, thickness: number?) -> nil
    TriangleFilled: (x1: number, y1: number, x2: number, y2: number, x3: number, y3: number, color: Color3, alpha: number?) -> nil 
    Gradient: (x: number, y: number, w: number, h: number, startColor: Color3, endColor: Color3, isHorizontal: boolean, startAlpha: number?, endAlpha: number?) -> nil
    Image: (textureId: number, x: number, y: number, w: number, h: number, r: number, g: number, b: number, a: number) -> nil
    Text: (text: string, x: number, y: number, color: Color3, font: DrawingFont?, alpha: number? ) -> nil
    TextOutlined: (text: string, x: number, y: number, color: Color3, font: DrawingFont?, alpha: number? ) -> nil
    GetTextSize: (text: string, font: DrawingFont) -> (number, number)
    ComputeConvexHull: (points: { number }) -> nil
    Polyline: (points: { number }, color: Color3, closed: boolean, thickness: number, alpha: number?) -> nil
    ConvexPolyFilled: (points: { number }, color: Color3, alpha: number?) -> nil
    GetPartCorners: (part: SerotoninPart) -> { Vector3 }?
end

declare class SerotoninUtility
    RandomInt: (min: number, max: number) -> number
    RandomFloat: (min: number, max: number) -> number
    GetTickCount: () -> number
    GetFingerprint: () -> string
    GetClipboard: () -> string
    MoveMouse: (dx: number, dy: number) -> nil
    GetDeltaTime: () -> number
    GetMousePos: () -> Vector2
    GetMenuState: () -> boolean
    WorldToScreen: (worldPos: Vector3) -> (number, number, boolean)
    LoadImage: (imagePath: string) -> number?
end

declare class SerotoninInputMouse
    Click: (button: MouseButton | number) -> nil
    IsClicked: (button: MouseButton | number) -> boolean
    Scroll: (delta: number) -> nil
end

declare class SerotoninInputKeyboard
    Press: (key: string | number) -> nil
    Release: (key: string | number) -> nil
    Click: (key: string | number, delay: number?) -> nil
    IsPressed: (key: string | number) -> boolean
end

declare class SerotoninUi
    getValue: (tab_ref: string, container_ref: string, name: string) -> any
    setValue: (tab_ref: string, container_ref: string, name: string, value: any) -> nil
    setVisibility: (tab_ref: string, container_ref: string, name: string, visible: boolean) -> nil
    newTab: (tab_ref: string, name: string) -> nil
    newContainer: (tab_ref: string, container_ref: string, name: string, options: UiContainerOptions?) -> nil
    newCheckbox: (tab_ref: string, container_ref: string, name: string, in_line: boolean?) -> nil
    newSliderInt: (tab_ref: string, container_ref: string, name: string, min: number, max: number, default: number?) -> nil
    newSliderFloat: (tab_ref: string, container_ref: string, name: string, min: number, max: number, default: number?) -> nil
    newDropdown: (tab_ref: string, container_ref: string, name: string, options: { string }, default_index: number?) -> nil
    newMultiselect: (tab_ref: string, container_ref: string, name: string, options: { string }) -> nil
    newColorpicker: (tab_ref: string, container_ref: string, name: string, default_color: Color3?, in_line: boolean?) -> nil
    newInputText: (tab_ref: string, container_ref: string, name: string, default_text: string?) -> nil
    newButton: (tab_ref: string, container_ref: string, name: string, callback: () -> nil) -> nil
    newListbox: (tab_ref: string, container_ref: string, name: string, options: { string }, callback: () -> nil?) -> nil
end

declare class SerotoninCheat
    register: (eventName: EventTypes, callback: () -> nil) -> nil
    getWindowSize: () -> (number, number)
end

declare class SerotoninFileManager
    Read: (path: string) -> string?
    Write: (path: string, content: string) -> boolean
end

declare class SerotoninHttp
    Get: (url: string, headers: { [string]: any }, callback: (response: any) -> nil) -> nil
    Post: (url: string, headers: { [string]: any }, body: string, callback: (response: any) -> nil) -> nil
end

declare game: SerotoninGame
declare entity: SerotoninEntityList
declare draw: SerotoninDrawing
declare utility: SerotoninUtility
declare mouse: SerotoninInputMouse
declare keyboard: SerotoninInputKeyboard
declare ui: SerotoninUi
declare cheat: SerotoninCheat
declare file: SerotoninFileManager
declare http: SerotoninHttp
