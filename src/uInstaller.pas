unit uInstaller;

interface

uses uIdHTTPProgress, IdSSLOpenSSL;

type
  TInstaller = class
    SSL: TIdSSLIOHandlerSocketOpenSSL;
    IdHTTPProgress: TIdHTTPProgress;
    procedure Install(const Path:string);
    constructor Create;
  private
    procedure Unpak(const FilePath: string);
  end;

implementation

uses uMain, JclCompression, Classes, inifiles, sysUtils;

{ TDownloader }

constructor TInstaller.Create;
begin
  IdHTTPProgress := TIdHTTPProgress.Create(Main);
  IdHTTPProgress.IOHandler := SSL;
  IdHTTPProgress.Request.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
  IdHTTPProgress.Request.UserAgent := 'Mozilla/3.0 (compatible; Indy Library)';
end;

procedure TInstaller.Unpak(const FilePath:string);
var
   archiveclass: TJclDecompressArchiveClass;
   archive: TJclDecompressArchive;
   item: TJclCompressionItem;
   s: String;
   i: Integer;
begin
   archiveclass := GetArchiveFormats.FindDecompressFormat(FilePath);

   if not Assigned(archiveclass) then
      raise Exception.Create('Nierozpoznany format pliku ' + FilePath);

   archive := archiveclass.Create(FilePath);
   try
      if not (archive is TJclSevenZipDecompressArchive) then
         raise Exception.Create('Ten format nie jest rozpoznany przez bibliotekê 7z.dll.');

      archive.ListFiles;

      s := Format('test.zip Iloœæ plików: %d'#13#10#13#10, [archive.ItemCount]);

      for i := 0 to archive.ItemCount - 1 do
      begin
         item := archive.Items[i];
         case item.Kind of
            ikFile:
               s := s + IntToStr(i+1) + ': ' + item.PackedName + #13#10;
            ikDirectory:
               s := s + IntToStr(i+1) + ': ' + item.PackedName + '\'#13#10;
         end;
      end;

      if archive.ItemCount > 0 then
      begin
//         archive.Items[0].Selected := true;
//         archive.ExtractSelected('F:\temp\test');

         archive.ExtractAll(Main.DIR + '\download\');
      end;
   finally
      archive.Free;
   end;
end;

procedure TInstaller.Install(const Path: string);
var
  IniFile : TIniFile;
  FileList, LinkList, TexturesList, Textures : TStringList;
  i : Integer;
  s : string;
  FileName : string;
begin
  IniFile := TIniFile.Create(Path);

  LinkList := TStringList.Create;
  IniFile.ReadSection('DOWNLOAD',LinkList);
  for i := 0 to LinkList.Count-1 do
  begin
    FileName := IniFile.ReadString('DOWNLOAD',LinkList[i],'');
    //IdHTTPProgress.DownloadFile(LinkList[i], Main.DIR + '\download' + FileName);
  end;

  for i := 0 to LinkList.Count-1 do
  begin
    FileName := IniFile.ReadString('DOWNLOAD',LinkList[i],'');
    Unpak(Main.DIR + 'download\' + FileName);
  end;
  LinkList.Free;

  TexturesList := TStringList.Create;
  IniFile.ReadSection('TEXTURES.TXT',TexturesList);
  for i := 0 to TexturesList.Count-1 do
  begin
    FileName := IniFile.ReadString('TEXTURES.TXT',TexturesList[i],'');
    Textures := TStringList.Create;

    if FileExists(Main.DIR + 'download\' + TexturesList[i] + '\textures.txt') then
      Textures.LoadFromFile(FileName);

    Textures.Add();
  end;

  FileList := TStringList.Create;
  IniFile.ReadSection('VERIFY',FileList);
  for i := 0 to FileList.Count-1 do
    if not FileExists(Main.DIR + 'download\' + FileList[i]) then
      s := 'Brak wymaganych plików';
  FileList.Free;
end;

end.
