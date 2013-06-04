## Encrypt assets in an Xcode project
Objective-C script that will encrypt a directory of files.  Ideally run the script in any Xcode project as part of your build (i.e. add a new target type 'External Build System' and specify the script).  Decrypt files individually at runtime.

### Basic usage

	EncryptAssets /path/to/folder/with/assets/ /path/to/destination/folder/for/encrypted/assets/ some_$3cr3t_key
  
### Adding to XCode project build
todo: details

### Decrypting files
use NSData+AES256 method:
```objective-c
-(NSData*) decryptedWithKey:(NSData*)key;
````
todo: details

### Contact
email: <jay@nerdcave.com> or twitter: [@nerdcave](http://twitter.com/nerdcave)
