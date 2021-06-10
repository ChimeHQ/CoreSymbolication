#ifndef CoreSymbolication_h
#define CoreSymbolication_h

#include <mach/machine.h>
#include <mach/vm_types.h>
#include <CoreFoundation/CoreFoundation.h>

typedef struct {
    void* data;
    void* obj;
} CSTypeRef;

typedef struct {
    uint64_t location;
    uint64_t length;
} CSRange;

typedef struct {
    cpu_type_t cpu_type;
    cpu_subtype_t cpu_subtype;
} CSArchitecture;

typedef CSTypeRef CSSymbolicatorRef;
typedef CSTypeRef CSSymbolOwnerRef;
typedef CSTypeRef CSUUIDRef;
typedef CSTypeRef CSSymbolRef;
typedef CSTypeRef CSSourceInfoRef;

#define kCSNull ((CSTypeRef) {NULL, NULL})
#define kCSNow 0x80000000u

Boolean CSIsNull(CSTypeRef cs);
CSTypeRef CSRetain(CSTypeRef cs);
void CSRelease(CSTypeRef cs);
void CSShow(CSTypeRef cs);

typedef void (^CSSymbolicatorIterator)(CSSymbolicatorRef symbolicator);

void CSSymbolicatorForeachSymbolicatorWithURL(CFURLRef url, CSSymbolicatorIterator it);

void CSSymbolicatorForeachSharedCache(CSSymbolicatorIterator it);

CSArchitecture CSSymbolicatorGetArchitecture(CSSymbolicatorRef symbolicator);

CSSymbolicatorRef CSSymbolicatorCreateWithURLAndArchitecture(CFURLRef url, CSArchitecture arch);

typedef void (^CSSymbolOwnerIterator)(CSSymbolOwnerRef owner);

int CSSymbolicatorForeachSymbolOwnerAtTime(CSSymbolicatorRef cs, uint64_t time, CSSymbolOwnerIterator it);
CSSymbolOwnerRef CSSymbolicatorGetSymbolOwnerWithNameAtTime(CSSymbolicatorRef cs, const char* name, uint64_t time);
CSSymbolOwnerRef CSSymbolicatorGetSymbolOwnerWithUUIDAtTime(CSSymbolicatorRef symbolicator, CFUUIDRef uuid, uint64_t time);

CSArchitecture CSArchitectureGetArchitectureForName(const char* arch);
const char* CSArchitectureGetFamilyName(CSArchitecture arch);

CSUUIDRef CSSymbolOwnerGetUUID(CSSymbolOwnerRef owner);

const CFUUIDBytes* CSSymbolOwnerGetCFUUIDBytes(CSSymbolOwnerRef owner);
vm_address_t CSSymbolOwnerGetBaseAddress(CSSymbolOwnerRef owner);

typedef void (^CSSymbolIterator)(CSSymbolRef symbol);

void CSSymbolOwnerForeachSymbol(CSSymbolOwnerRef owner, CSSymbolIterator interator);
const char* CSSymbolOwnerGetName(CSSymbolOwnerRef owner);
CSArchitecture CSSymbolOwnerGetArchitecture(CSSymbolOwnerRef owner);
const char* CSSymbolOwnerGetPath(CSSymbolOwnerRef owner);
const char* CSSymbolOwnerGetPathForSymbolication(CSSymbolOwnerRef owner);

const char* CSSymbolGetMangledName(CSSymbolRef symbol);
const char* CSSymbolGetName(CSSymbolRef symbol);
CSRange CSSymbolGetRange(CSSymbolRef symbol);
Boolean CSSymbolIsFunction(CSSymbolRef sym);

typedef void (^CSSourceInfoIterator)(CSSourceInfoRef sourceInfo);

void CSSymbolForeachSourceInfo(CSSymbolRef symbol, CSSourceInfoIterator);

int CSSourceInfoGetLineNumber(CSSourceInfoRef info);
const char* CSSourceInfoGetPath(CSSourceInfoRef info);
CSRange CSSourceInfoGetRange(CSSourceInfoRef info);

#endif /* CoreSymbolication_h */
