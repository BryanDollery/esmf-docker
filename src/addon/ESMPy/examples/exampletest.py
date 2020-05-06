# $Id$

"""
examples test file
"""
try:
    from unittest import SkipTest
except ImportError:
    from nose import SkipTest

from ESMF.test.base import TestBase, attr
import ESMF.api.constants as constants

class TestExamples(TestBase):

    def test_helloworld(self):
        from . import hello_world

    @attr('parallel')
    def test_crff(self):
        from . import create_read_from_file

    @attr('serial')
    # @attr('parallel')
    def test_gridmeshrg(self):
        if constants._ESMF_COMM == constants._ESMF_COMM_MPIUNI:
            raise SkipTest('ESMF must be built with MPI for test')
        else:
            from . import grid_mesh_regrid

    @attr('parallel')
    def test_field_read(self):
        from . import field_read

    @attr('slow')
    def test_tripolerg(self):
        from . import tripole_regrid

    def test_ungriddedrg(self):
        from . import ungridded_dimension_regrid

    def test_gridcreateperimask(self):
        from . import grid_create_peridim_mask

    def test_meshlocstreamregrid(self):
        from . import mesh_locstream_regrid

    def test_gridlocstreamregrid(self):
        from . import grid_locstream_regrid

    def test_locstreamgridregrid(self):
        from . import locstream_grid_regrid

    def test_ugrid_latlon_regrid(self):
        from . import ugrid_latlon_regrid
