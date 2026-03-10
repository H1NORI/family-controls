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
* [`requestPermission()`](#requestpermission)

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


### requestPermission()

```typescript
requestPermission() => Promise<{ granted: boolean; }>
```

**Returns:** <code>Promise&lt;{ granted: boolean; }&gt;</code>

--------------------

</docgen-api>
