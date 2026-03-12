# family-controls

Implements IOS Family COntrols API

## Install

To use npm

```bash
npm install family-controls
````

To use yarn

```bash
yarn add family-controls
```

Sync native files

```bash
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`checkPermission()`](#checkpermission)
* [`requestPermission()`](#requestpermission)
* [`openAppPicker(...)`](#openapppicker)
* [`getGroups()`](#getgroups)
* [`saveGroup(...)`](#savegroup)
* [`blockGroup()`](#blockgroup)
* [`unblockAll()`](#unblockall)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### checkPermission()

```typescript
checkPermission() => Promise<{ status: boolean; }>
```

**Returns:** <code>Promise&lt;{ status: boolean; }&gt;</code>

--------------------


### requestPermission()

```typescript
requestPermission() => Promise<{ granted: boolean; }>
```

**Returns:** <code>Promise&lt;{ granted: boolean; }&gt;</code>

--------------------


### openAppPicker(...)

```typescript
openAppPicker(options?: { id?: string | undefined; } | undefined) => Promise<{ selectedApps: number; selectedCategories: number; totalApps: number; totalCategories: number; }>
```

| Param         | Type                          |
| ------------- | ----------------------------- |
| **`options`** | <code>{ id?: string; }</code> |

**Returns:** <code>Promise&lt;{ selectedApps: number; selectedCategories: number; totalApps: number; totalCategories: number; }&gt;</code>

--------------------


### getGroups()

```typescript
getGroups() => Promise<{ groups: BlockGroup[]; }>
```

**Returns:** <code>Promise&lt;{ groups: BlockGroup[]; }&gt;</code>

--------------------


### saveGroup(...)

```typescript
saveGroup(options?: { id?: string | undefined; name?: string | undefined; blocking?: number | undefined; } | undefined) => Promise<void>
```

| Param         | Type                                                            |
| ------------- | --------------------------------------------------------------- |
| **`options`** | <code>{ id?: string; name?: string; blocking?: number; }</code> |

--------------------


### blockGroup()

```typescript
blockGroup() => Promise<void>
```

--------------------


### unblockAll()

```typescript
unblockAll() => Promise<void>
```

--------------------


### Interfaces


#### BlockGroup

| Prop                     | Type                |
| ------------------------ | ------------------- |
| **`id`**                 | <code>string</code> |
| **`name`**               | <code>string</code> |
| **`blocking`**           | <code>number</code> |
| **`selectedApps`**       | <code>number</code> |
| **`selectedCategories`** | <code>number</code> |
| **`totalApps`**          | <code>number</code> |
| **`totalCategories`**    | <code>number</code> |

</docgen-api>
