TEMPLATE = app

QT += qml quick widgets

win32 {
    DEFINES -= UNICODE
    DEFINES += _MBCS
}

CONFIG  += c++11

SOURCES += main.cpp \
    system/settingsvalult.cpp \
    services/GoogleTranslate/googletranslate.cpp

HEADERS += \
    defines.h \
    system/settingsvalult.h \
    services/GoogleTranslate/googletranslate.h \
    utills/singletonwithconfig.h \
    services/GoogleTranslate/googletranslateconfig.h

# -----------------------------
# Controllers
# -----------------------------

SOURCES += \
    controllers/applicationcontroller.cpp \
    controllers/filecontroller.cpp \
    controllers/soundcontroller.cpp \
    controllers/settingscontroller.cpp \
    controllers/speechcontroller.cpp

HEADERS += \
    controllers/applicationcontroller.h \
    controllers/speechcontroller.h \
    controllers/filecontroller.h \
    controllers/soundcontroller.h \
    controllers/settingscontroller.h

# -----------------------------
# Models
# -----------------------------

SOURCES += \
    models/fileobject.cpp \
    models/deviceobject.cpp \
    models/localeobject.cpp

HEADERS += \
    models/fileobject.h \
    models/deviceobject.h \
    models/localeobject.h

# -----------------------------
# Services
# -----------------------------

# Google speech to text service

SOURCES += \
    services/Google/googlespeech.cpp

HEADERS += \
    services/Google/googlespeech.h

# Sound IO service

SOURCES += \
    services/sound/autosoundrecorder.cpp \
    services/sound/buffer.cpp \
    services/sound/soundplayer.cpp \
    services/sound/soundrecorder.cpp

HEADERS += \
    services/sound/autosoundrecorder.h \
    services/sound/buffer.h \
    services/sound/soundplayer.h \
    services/sound/soundrecorder.h

# TTS
DEFINES += QTSPEECH_STATIC
include(./services/tts/qtspeech/QtSpeech.pri)

SOURCES += \
    services/tts/tts.cpp

HEADERS +=  \
    services/tts/tts.h

# -----------------------------
# Utills
# -----------------------------

# DP Analyse

SOURCES += \
    utills/dp-analyse/spectrdp.cpp \
    utills/dp-analyse/vectordp.cpp

HEADERS += \
    utills/dp-analyse/dp.h \
    utills/dp-analyse/spectrdp.h \
    utills/dp-analyse/vectordp.h

# OpenAL

SOURCES += \
    utills/OpenAL/wavFile.cpp \
    utills/OpenAL/openal_wrapper.cpp

HEADERS  += \
    utills/OpenAL/openal_wrapper.h \
    utills/OpenAL/wavFile.h

win32{
    INCLUDEPATH += "c:/Dev/openal-soft-1.15.1-bin/include"
    LIBS += "c:/Dev/openal-soft-1.15.1-msvc/Debug/OpenAL32.lib"
}

unix:!mac {
    LIBS += -lopenal
}

# Other

SOURCES += \
    utills/files.cpp

HEADERS  += \
    utills/files.h \
    utills/singleton.h

# SPTK

INCLUDEPATH += ./utills/SPTK

SOURCES +=  \
    utills/SPTK/sptk.c\
    utills/SPTK/agexp.c\
    utills/SPTK/cholesky.c \
    utills/SPTK/fileio.c \
    utills/SPTK/fillz.c \
    utills/SPTK/getfp.c \
    utills/SPTK/getmem.c \
    utills/SPTK/gexp.c \
    utills/SPTK/glog.c \
    utills/SPTK/invert.c \
    utills/SPTK/matrix.c \
    utills/SPTK/movem.c \
    utills/SPTK/mseq.c \
    utills/SPTK/theq.c \
    utills/SPTK/toeplitz.c \
    utills/SPTK/vector.c \
#    utills/SPTK/acep/acep.c \
#    utills/SPTK/acep/_acep.c \
#    utills/SPTK/acorr/acorr.c \
    utills/SPTK/acorr/_acorr.c \
#    utills/SPTK/agcep/agcep.c \
#    utills/SPTK/agcep/_agcep.c \
#    utills/SPTK/amcep/amcep.c \
#    utills/SPTK/amcep/_amcep.c \
#    utills/SPTK/average/average.c \
#    utills/SPTK/average/_average.c \
#    utills/SPTK/b2mc/b2mc.c \
#    utills/SPTK/b2mc/_b2mc.c \
#    utills/SPTK/bcp/bcp.c \
#    utills/SPTK/bcut/bcut.c \
#    utills/SPTK/c2acr/c2acr.c \
#    utills/SPTK/c2acr/_c2acr.c \
#    utills/SPTK/c2ir/c2ir.c \
#    utills/SPTK/c2ir/_c2ir.c \
#    utills/SPTK/c2sp/c2sp.c \
#    utills/SPTK/c2sp/_c2sp.c \
#    utills/SPTK/cat2/cat2.c \
#    utills/SPTK/cdist/cdist.c \
#    utills/SPTK/clip/clip.c \
#    utills/SPTK/clip/_clip.c \
#    utills/SPTK/da/dawrite.c \
#    utills/SPTK/da/winplay.c \
#    utills/SPTK/dct/dct.c \
#    utills/SPTK/dct/_dct.c \
#    utills/SPTK/decimate/decimate.c \
#    utills/SPTK/delay/delay.c \
#    utills/SPTK/delta/delta.c \
#    utills/SPTK/df2/df2.c \
#    utills/SPTK/df2/_df2.c \
#    utills/SPTK/dfs/dfs.c \
#    utills/SPTK/dfs/_dfs.c \
#    utills/SPTK/dmp/dmp.c \
#    utills/SPTK/ds/ds.c \
#    utills/SPTK/dtw/dtw.c \
#    utills/SPTK/echo2/echo2.c \
#    utills/SPTK/excite/excite.c \
#    utills/SPTK/extract/extract.c \
#    utills/SPTK/fd/fd.c \
#    utills/SPTK/fft2/fft2.c \
#    utills/SPTK/fft2/_fft2.c \
#    utills/SPTK/fft/fft.c \
    utills/SPTK/fft/_fft.c \
#    utills/SPTK/fftcep/fftcep.c \
#    utills/SPTK/fftcep/_fftcep.c \
#    utills/SPTK/fftr2/fftr2.c \
#    utills/SPTK/fftr2/_fftr2.c \
#    utills/SPTK/fftr/fftr.c \
    utills/SPTK/fftr/_fftr.c \
#    utills/SPTK/fig+fdrw/fdrw.c \
#    utills/SPTK/fig+fdrw/fig.c \
#    utills/SPTK/fig+fdrw/fig0.c \
#    utills/SPTK/fig+fdrw/fig1.c \
#    utills/SPTK/fig+fdrw/plot.c \
#    utills/SPTK/fig+fdrw/plsub.c \
    utills/SPTK/frame/frame.c \
#    utills/SPTK/freqt/freqt.c \
#    utills/SPTK/freqt/_freqt.c \
#    utills/SPTK/gc2gc/gc2gc.c \
#    utills/SPTK/gc2gc/_gc2gc.c \
#    utills/SPTK/gcep/gcep.c \
#    utills/SPTK/gcep/_gcep.c \
#    utills/SPTK/glsadf/glsadf.c \
#    utills/SPTK/glsadf/_glsadf.c \
#    utills/SPTK/gmm/gmm.c \
#    utills/SPTK/gmm/_gmm.c \
#    utills/SPTK/gmm/gmmp.c \
#    utills/SPTK/gnorm/gnorm.c \
#    utills/SPTK/gnorm/_gnorm.c \
#    utills/SPTK/grpdelay/grpdelay.c \
#    utills/SPTK/grpdelay/_grpdelay.c \
#    utills/SPTK/histogram/histogram.c \
#    utills/SPTK/histogram/_histogram.c \
#    utills/SPTK/idct/idct.c \
#    utills/SPTK/ifft2/ifft2.c \
#    utills/SPTK/ifft2/_ifft2.c \
#    utills/SPTK/ifft/ifft.c \
#    utills/SPTK/ifft/_ifft.c \
#    utills/SPTK/ifftr/ifftr.c \
#    utills/SPTK/ifftr/_ifftr.c \
#    utills/SPTK/ignorm/ignorm.c \
#    utills/SPTK/ignorm/_ignorm.c \
#    utills/SPTK/impulse/impulse.c \
#    utills/SPTK/imsvq/imsvq.c \
#    utills/SPTK/imsvq/_imsvq.c \
#    utills/SPTK/interpolate/interpolate.c \
#    utills/SPTK/ivq/ivq.c \
#    utills/SPTK/ivq/_ivq.c \
#    utills/SPTK/lbg/lbg.c \
#    utills/SPTK/lbg/_lbg.c \
#    utills/SPTK/levdur/levdur.c \
    utills/SPTK/levdur/_levdur.c \
#    utills/SPTK/linear_intpl/linear_intpl.c \
#    utills/SPTK/lmadf/lmadf.c \
#    utills/SPTK/lmadf/_lmadf.c \
#    utills/SPTK/lpc2c/lpc2c.c \
#    utills/SPTK/lpc2c/_lpc2c.c \
#    utills/SPTK/lpc2lsp/lpc2lsp.c \
#    utills/SPTK/lpc2lsp/_lpc2lsp.c \
#    utills/SPTK/lpc2par/lpc2par.c \
#    utills/SPTK/lpc2par/_lpc2par.c \
    utills/SPTK/lpc/lpc.c \
    utills/SPTK/lpc/_lpc.c \
#    utills/SPTK/lsp2lpc/lsp2lpc.c \
#    utills/SPTK/lsp2lpc/_lsp2lpc.c \
#    utills/SPTK/lsp2sp/lsp2sp.c \
#    utills/SPTK/lsp2sp/_lsp2sp.c \
#    utills/SPTK/lspcheck/lspcheck.c \
#    utills/SPTK/lspcheck/_lspcheck.c \
#    utills/SPTK/lspdf/lspdf.c \
#    utills/SPTK/lspdf/_lspdf.c \
#    utills/SPTK/ltcdf/ltcdf.c \
#    utills/SPTK/ltcdf/_ltcdf.c \
#    utills/SPTK/mc2b/mc2b.c \
#    utills/SPTK/mc2b/_mc2b.c \
#    utills/SPTK/mcep/mcep.c \
#    utills/SPTK/mcep/_mcep.c \
#    utills/SPTK/merge/merge.c \
#    utills/SPTK/mfcc/mfcc.c \
#    utills/SPTK/mfcc/_mfcc.c \
#    utills/SPTK/mgc2mgc/mgc2mgc.c \
#    utills/SPTK/mgc2mgc/_mgc2mgc.c \
#    utills/SPTK/mgc2sp/mgc2sp.c \
#    utills/SPTK/mgc2sp/_mgc2sp.c \
#    utills/SPTK/mgcep/mgcep.c \
#    utills/SPTK/mgcep/_mgcep.c \
#    utills/SPTK/mglsadf/mglsadf.c \
#    utills/SPTK/mglsadf/_mglsadf.c \
#    utills/SPTK/minmax/minmax.c \
#    utills/SPTK/mlpg/mlpg.c \
#    utills/SPTK/mlpg/_mlpg.c \
#    utills/SPTK/mlsacheck/mlsacheck.c \
#    utills/SPTK/mlsadf/mlsadf.c \
#    utills/SPTK/mlsadf/_mlsadf.c \
#    utills/SPTK/msvq/msvq.c \
#    utills/SPTK/msvq/_msvq.c \
#    utills/SPTK/nan/nan.c \
#    utills/SPTK/norm0/norm0.c \
#    utills/SPTK/norm0/_norm0.c \
#    utills/SPTK/nrand/nrand.c \
    utills/SPTK/nrand/_nrand.c \
#    utills/SPTK/par2lpc/par2lpc.c \
#    utills/SPTK/par2lpc/_par2lpc.c \
#    utills/SPTK/pca/pca.c \
#    utills/SPTK/pca/pcas.c \
#    utills/SPTK/phase/phase.c \
#    utills/SPTK/phase/_phase.c \
    utills/SPTK/pitch/pitch.c \
    utills/SPTK/pitch/snack/jkGetF0.c \
    utills/SPTK/pitch/snack/sigproc.c \
    utills/SPTK/pitch/swipe/swipe.c \
#    utills/SPTK/poledf/poledf.c \
#    utills/SPTK/poledf/_poledf.c \
#    utills/SPTK/psgr/dict.c \
#    utills/SPTK/psgr/eps.c \
#    utills/SPTK/psgr/plot.c \
#    utills/SPTK/psgr/psgr.c \
#    utills/SPTK/ramp/ramp.c \
#    utills/SPTK/rawtowav/rawtowav.c \
#    utills/SPTK/reverse/reverse.c \
#    utills/SPTK/reverse/_reverse.c \
#    utills/SPTK/rmse/rmse.c \
#    utills/SPTK/rmse/_rmse.c \
#    utills/SPTK/root_pol/root_pol.c \
#    utills/SPTK/root_pol/_root_pol.c \
#    utills/SPTK/sin/sin.c \
#    utills/SPTK/smcep/smcep.c \
#    utills/SPTK/smcep/_smcep.c \
#    utills/SPTK/snr/snr.c \
#    utills/SPTK/sopr/sopr.c \
    utills/SPTK/spec/spec.c \
#    utills/SPTK/step/step.c \
#    utills/SPTK/swab/swab.c \
#    utills/SPTK/symmetrize/symmetrize.c \
#    utills/SPTK/train/train.c \
#    utills/SPTK/transpose/transpose.c \
#    utills/SPTK/transpose/_transpose.c \
#    utills/SPTK/uels/uels.c \
#    utills/SPTK/uels/_uels.c \
#    utills/SPTK/ulaw/ulaw.c \
#    utills/SPTK/ulaw/_ulaw.c \
#    utills/SPTK/us/us.c \
#    utills/SPTK/vc/vc.c \
#    utills/SPTK/vc/_vc.c \
#    utills/SPTK/vc/hts_engine_API/HTS_misc.c \
#    utills/SPTK/vc/hts_engine_API/HTS_pstream.c \
#    utills/SPTK/vc/hts_engine_API/HTS_sstream.c \
#    utills/SPTK/vopr/vopr.c \
#    utills/SPTK/vq/vq.c \
#    utills/SPTK/vq/_vq.c \
#    utills/SPTK/vstat/vstat.c \
#    utills/SPTK/vsum/vsum.c \
    utills/SPTK/window/window.c \
    utills/SPTK/window/_window.c \
    utills/SPTK/x2x/x2x.c \
#    utills/SPTK/xgr/plot.c \
#    utills/SPTK/xgr/window.c \
#    utills/SPTK/xgr/xgr.c \
#    utills/SPTK/zcross/zcross.c \
#    utills/SPTK/zcross/_zcross.c \
#    utills/SPTK/zerodf/zerodf.c \
#    utills/SPTK/zerodf/_zerodf.c \

HEADERS  += \
    utills/SPTK/SPTK.h \
    utills/SPTK/vector.h \
#    utills/SPTK/da/da.h \
#    utills/SPTK/da/winplay.h \
#    utills/SPTK/fig+fdrw/fig.h \
#    utills/SPTK/fig+fdrw/plot.h \
    utills/SPTK/lpc/lpc.h \
    utills/SPTK/pitch/pitch.h \
    utills/SPTK/pitch/snack/jkGetF0.h \
    utills/SPTK/frame/frame.h \
#    utills/SPTK/psgr/psgr.h \
#    utills/SPTK/vc/hts_engine_API/HTS_engine.h \
#    utills/SPTK/vc/hts_engine_API/HTS_hidden.h \
    utills/SPTK/spec/spec.h \
    utills/SPTK/window/window.h \
    utills/SPTK/x2x/x2x.h \
#    utills/SPTK/xgr/config.h \
#    utills/SPTK/xgr/gcdata.h \
#    utills/SPTK/xgr/xgr.h

OTHER_FILES += \
    images/* \

RESOURCES += qml.qrc

TRANSLATIONS = qml/i18n/speech-apps_ru.ts \
               qml/i18n/speech-apps_en.ts \
               qml/i18n/speech-apps_be.ts

lupdate_only {
    SOURCES = \
        qml/*.qml \
        qml/ScreenRecords/FileListDelegate.qml
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    qml/main.qml \
    qml/MainMenu.qml \
    qml/ScreenParrot.qml \
    qml/ScreenRecords.qml \
    qml/ScreenRecords/FileListDelegate.qml \
    qml/ScreenSettings.qml \
    qml/ScreenWhiteBull.qml \
    qml/SpeechScreen.qml \
    qml/ScreenTests.qml \
    logic/white-bull-logic.qml \
    logic/parot-logic.qml \
    logic/Utils/Messages.qml


# Copy external qml files post build
external-logic.commands = $(COPY_DIR) $$PWD/logic $$OUT_PWD
first.depends = $(first) external-logic
export(first.depends)
export(external-logic.commands)
QMAKE_EXTRA_TARGETS += first external-logic
