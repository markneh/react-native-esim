# react-native-esim

This package exposes iOS API to install eSIM plans. Android support is planned in the future.
#### Warning: This API won't work without eSIM entitlement. You can read more about it [here](https://stackoverflow.com/a/60162323)
#### Note: At the moment (iOS 14.2) there might a bug in iOS sdk which returns uknown result before eSIM setup completion. More about it [here](https://developer.apple.com/forums/thread/662001)

## Installation

```sh
npm install react-native-esim
```

You then need to link the native parts of the library for the platforms you are using.

#### Linking in React Native >= 0.60

Linking the package is not required anymore with [Autolinking](https://github.com/react-native-community/cli/blob/master/docs/autolinking.md).

- **iOS Platform:**

  `$ npx pod-install`

#### Linking in React Native < 0.60

The easiest way to link the library is using the CLI tool by running this command from the root of your project:

```
react-native link react-native-esim
```

If you can't or don't want to use the CLI tool, you can also manually link the library using the instructions below (click on the arrow to show them):

<details>
<summary>Manually link the library on iOS</summary>

Either follow the [instructions in the React Native documentation](https://facebook.github.io/react-native/docs/linking-libraries-ios#manual-linking) to manually link the framework or link using [Cocoapods](https://cocoapods.org) by adding this to your `Podfile`:

```ruby
pod 'react-native-esim', :path => '../node_modules/react-native-esim'
```

</details>

## Usage

```js
import EsimManager from "react-native-esim";

// ...
EsimManager.isEsimSupported()
  .then((result) => {
    // result might be true or false
  })
  .catch((error) => {
    // you might get and error if app wasn't configured correctly
    // or device iOS is lower than required minimum
  });
  
const config = {
  address: "";
  confirmationCode?: "";
  eid?: "";
  iccid?: "";
  matchingId?: "";
  oid?: "";
}
  
EsimManager.setupEsim(config)
  .then((result) => {
    // result might be success/fail/uknown
  })
  .catch((error) => {
    // you might get an error if app wasn't configured correctly
    // or passed configuration is invalid
  });
```

## API

### Methods

| **Method**        | **Parameter**                | **Description**                                                             |
|-------------------|------------------------------|-----------------------------------------------------------------------------|
| `isEsimSupported` | `void`                       | This method only checks to ensure that the device supports eSIM installation. Returns `boolean`. Might throw an error. |
| `setupEsim`       | `EsimConfig`                 | Starts the provisioning process for a specified eSIM. Might throw and error. Returns `EsimSetupResultStatus` |

#### EsimConfig

| **Property**       | **Type** | **Required** | **Description** |
|--------------------|----------|--------------|-----------------|
| `address`          | string   | **true**     | The address of the carrier network’s eSIM server. |
| `confirmationCode` | string   | false        | The provisioning request’s confirmation code, provided by the network operator when initiating an eSIM download. |
| `eid`              | string   | false        | The provisioning request’s eUICC identifier (EID). |
| `iccid`            | string   | false        | The provisioning request’s Integrated Circuit Card Identifier (ICCID). |
| `matchingId`       | string   | false        | The provisioning request’s matching identifier (MatchingID). |
| `oid`              | string   | false        | The provisioning request’s Object Identifier (OID). |

#### EsimSetupResultStatus

| **StatusType** | **Value** |
|----------------|-----------|
| `Unknown`      | 0         |
| `Fail`      | 1         |
| `Success`      | 2         |

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
