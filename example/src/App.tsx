import React, { useEffect, useState, useCallback } from 'react';
import { StyleSheet, View, Text, Button } from 'react-native';
import EsimManager, { EsimSetupResultStatus } from 'react-native-esim';

export default function App() {
  const [supported, setSupported] = useState<boolean>();

  const supportStatus = supported ? 'Supported' : 'Not supported';

  useEffect((): void => {
    EsimManager.isEsimSupported().then(setSupported);
  }, []);

  const performSetup = useCallback((): void => {
    EsimManager.setupEsim({ address: 'address.com' })
      .then((result): void => {
        console.log(result);
        switch (result) {
          case EsimSetupResultStatus.Unknown:
            console.log('esim setup unknown');
            break;
          case EsimSetupResultStatus.Fail:
            console.log('esim setup fail');
            break;
          case EsimSetupResultStatus.Success:
            console.log('esim setup success');
            break;
        }
      })
      .catch((error): void => {
        console.log(error);
      });
  }, []);

  return (
    <View style={styles.container}>
      <Text>
        Support status: {supported === undefined ? 'Loading...' : supportStatus}
      </Text>
      <Button title="Setup" onPress={performSetup} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
